//
//  FetchCourseDeadlines.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/7.
//

import Foundation

class DeadlineFetcher {
    let iaaaOauth: String = "https://iaaa.pku.edu.cn/iaaa/oauthlogin.do"
    let portalValidate: String = "https://portal.pku.edu.cn/portal2017/ssoLogin.do"
    let courseLoginBase: String = "https://course.pku.edu.cn/webapps/bb-sso-bb_bb60/execute/authValidate/campusLogin"
    let selectedCalendarBase: String = "https://course.pku.edu.cn/webapps/calendar/calendarData/selectedCalendarEvents"
    let appid: String = "blackboard"
    let redirUrl: String = "https://course.pku.edu.cn/webapps/bb-sso-bb_bb60/execute/authValidate/campusLogin"
    let courseLoginReferer: String = "https://iaaa.pku.edu.cn/iaaa/oauth.jsp"
    let campusCookieBase: String = "https://course.pku.edu.cn/webapps/login"
    let MILLISECONDS_OF_A_WEEK: Int64 = 604800000
    
    var token: String?

    // Fetch course deadlines once
    // returns nil if it fails
    // Side effect: fetch token each time
    func fetchCourseDeadlines(studentID: String, password: String) -> DeadlineJSONList? {
        var fetchedDeadlineJSONList: DeadlineJSONList?
        
        token = fetchIaaaToken(studentID: studentID, password: password)
        guard token != nil else { return nil }
        let courseLoginQuery = [
            "_rand": "0.5",
            "token": token!
        ]
        synchronizedConnect(baseString: courseLoginBase, queryKeys: courseLoginQuery, referer: courseLoginReferer)
        synchronizedConnect(baseString: campusCookieBase)
        fetchedDeadlineJSONList = connectToCalendar()
        
        return fetchedDeadlineJSONList
    }
    
    struct SuccessfulTokenResponse: Codable {
        var success: Bool
        var token: String
    }
    
    func fetchIaaaToken(studentID: String, password: String) -> String? {
        var token: String?
        var responseMessage: SuccessfulTokenResponse?
        
        let tokenQuery: [String: String] = [
            "appid": appid,
            "userName": studentID,
            "password": password,
            "randCode": "",
            "smsCode": "",
            "optCode": "",
            "redirUrl": redirUrl
        ]
        
        let fetchedData = synchronizedConnect(baseString: iaaaOauth, httpMethod: "POST", queryKeys: tokenQuery)
        
        if let data = fetchedData {
            responseMessage = try? JSONDecoder().decode(SuccessfulTokenResponse.self, from: data)
        }
        
        if let successfulResponse = responseMessage {
            token = successfulResponse.token
        }
        
        return token
    }
    
    func validateAccount(studentID: String, password: String) -> Bool {
        fetchIaaaToken(studentID: studentID, password: password) == nil ? false : true
    }

    func connectToCalendar(weeksBefore: Int64 = -4, weeksAfter: Int64 = 4) -> DeadlineJSONList? {
        var fetchedDeadlineJSONList: DeadlineJSONList?
        
        let currTimeInMilli: Int64 = Date().timeIntervalSince1970InMilli
        let selectedQuery: [String: String] = [
            "start": String(currTimeInMilli + MILLISECONDS_OF_A_WEEK * weeksBefore),
            "end": String(currTimeInMilli + MILLISECONDS_OF_A_WEEK * weeksAfter),
            "course_id": "",
            "mode": "personal"
        ]
        
        let fetchedData = synchronizedConnect(baseString: selectedCalendarBase, queryKeys: selectedQuery)
        
        fetchedDeadlineJSONList = (fetchedData != nil) ? (try? JSONDecoder().decode(DeadlineJSONList.self, from: fetchedData!)) : nil
        
        return fetchedDeadlineJSONList
    }
}

extension URL {
    init?(string: String, requestKeys: [String: String]) {
        var components = URLComponents(url: URL(string: string)!, resolvingAgainstBaseURL: false)!
        components.queryItems = []
        
        for (key, value) in requestKeys {
            components.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        if let finalURL = components.url {
            self = finalURL
        } else {
            return nil
        }
    }
}

extension Date {
    var timeIntervalSince1970InMilli: Int64 {
        Int64(self.timeIntervalSince1970 * 1000)
    }
}


@discardableResult
func synchronizedConnect(baseString: String, httpMethod: String = "GET", queryKeys: [String: String]? = nil, referer: String? = nil, setCookies: Bool = true) -> Data? {
    var returnData: Data?
    let connectURL: URL
    
    if let queryKeys = queryKeys {
        connectURL = URL(string: baseString, requestKeys: queryKeys)!
    } else {
        connectURL = URL(string: baseString)!
    }
    
    var connectRequest = URLRequest(url: connectURL)
    connectRequest.httpMethod = httpMethod
    if let referer = referer {
        connectRequest.setValue(referer, forHTTPHeaderField: "Referer")
    }
    if setCookies, let cookies = HTTPCookieStorage.shared.cookies(for: connectURL) {
        let cookieString = HTTPCookie.requestHeaderFields(with: cookies)["Cookie"]
        connectRequest.setValue(cookieString, forHTTPHeaderField: "Cookie")
    }
    
    let connectSemaphore = DispatchSemaphore(value: 0)
    let connectTask = URLSession.shared.dataTask(with: connectRequest) { data, response, error in
        if let error = error {
            print("Error: \(error)")
        }
        
        if let response = response as? HTTPURLResponse {
            if response.statusCode != 200 {
                print("Unexpected status code: \(response.statusCode)")
            }
        }
        
        if let data = data {
            returnData = data
        }
        
        connectSemaphore.signal()
    }
    
    connectTask.resume()
    connectSemaphore.wait()
    
    return returnData
}

