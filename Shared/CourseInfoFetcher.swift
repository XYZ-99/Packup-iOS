//
//  CourseInfoFetcher.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/30.
//

import Foundation

class CourseInfoFetcher {
    let portalLoginBaseUrl = "https://portal.pku.edu.cn/portal2017"
    let portalRedirUrl = "https://portal.pku.edu.cn/portal2017/ssoLogin.do"
    let portalValidateBaseUrl = "https://portal.pku.edu.cn/portal2017/ssoLogin.do"
    let redirUrl = "https://portal.pku.edu.cn/portal2017/ssoLogin.do"
    let iaaaOauth: String = "https://iaaa.pku.edu.cn/iaaa/oauthlogin.do"
    let courseInfoBaseUrl = "https://portal.pku.edu.cn/portal2017/bizcenter/course/getCourseInfo.do"
    let appid = "portal2017"
    
    func fetchCourseInfo(studentID: String, password: String) -> CourseInfoJSON? {
        let token: String? = fetchIaaaToken(studentID: studentID, password: password)
        // TODO: throw Error
        guard token != nil else { return nil }
        
        let portalValidateQuery = [
            "_rand": "0.13777814720603",
            "token": token!
        ]
        
        // fetchPortalCookies
        synchronizedConnect(baseString: portalLoginBaseUrl)
        // validateIaaaTokenInPortal
        synchronizedConnect(baseString: portalValidateBaseUrl, queryKeys: portalValidateQuery)
        
        // fetchPortalCourseInfo
        // TODO: Automatic deduction of semester
        let courseInfoQuery: [String: String] = [
            "xndxq": Semester(yearStart: 20, season: .FALL).toRequestString()
        ]
        
        let data = synchronizedConnect(baseString: courseInfoBaseUrl, httpMethod: "POST",queryKeys: courseInfoQuery)
        
        // TODO: throw Error
        guard data != nil else { return nil }
        let courseInfoJSON: CourseInfoJSON? = CourseInfoJSON(data: data!)
        
        // TODO: since `data` might be incorrect, DISTINGUISH THIS `nil` from the other two
        return courseInfoJSON
    }
    
    // MARK: - TODO: Merge with DeadlineFetcher
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
    // MARK: End TODO -
    
}

enum SemesterSeason: Int {
    case FALL = 1, SPRING, SUMMER
}

// TODO: automatic deduction
// For now, Semester(20, FALL)
struct Semester {
    let yearStart: Int
    let season: SemesterSeason
    
    // Could be a computed var
    func toRequestString() -> String {
        return "\(yearStart % 100)-\((yearStart + 1) % 100)-\(season.rawValue)"
    }
}
