//
//  Packup.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/11.
//

import Foundation
import Combine
import CoreData

class Packup: ObservableObject {
    // MARK: - Time Constants
    let backgroundCheckTimeInterval = TimeInterval(10 * 24 * 60 * 60)       // 10 days
    let accountInfoExpireTimeInterval = TimeInterval(30 * 24 * 60 * 60)     // 30 days
    
    // MARK: - Stored variables
    var studentID: String {
        get {
            UserDefaults.standard.string(forKey: "studentID") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "studentID")
        }
    }
    var password: String {
        get {
            UserDefaults.standard.string(forKey: "password") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "password")
        }
    }
    var lastConnectedToDeadlineTime: Date? {
        get {
            UserDefaults.standard.object(forKey: "lastConnectedToDeadlineTime") as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lastConnectedToDeadlineTime")
        }
    }
    
    // MARK: - Deadline Fetcher
    var deadlineFetcher: DeadlineFetcher = DeadlineFetcher()
    var infoExpired: Bool {
        if let lastConnectedToDeadlineTime = lastConnectedToDeadlineTime {
            if lastConnectedToDeadlineTime + accountInfoExpireTimeInterval < Date() {
                print(1)
                // Outdated
                return true
            } else {
                print(2)
                return false
            }
        } else {
            print(3)
            // Not yet connected
            return true
        }
    }
    var backgroundCheckTimerPublisher: Timer.TimerPublisher
    var cancellable: AnyCancellable?
    func validateAccount() -> Bool {
        if studentID.count != 10 || (UInt32(studentID) == nil) {
            return false
        }
        let valid = deadlineFetcher.validateAccount(studentID: studentID, password: password)
        if valid {
            lastConnectedToDeadlineTime = Date()
        }
        return valid
    }
    func fetchCourseDeadlineAndUpdate(context: NSManagedObjectContext) {
        let deadlineJSONList: DeadlineJSONList = deadlineFetcher.fetchCourseDeadlines(studentID: studentID, password: password) ?? []
        print(deadlineJSONList.count)
        for deadlineJSON in deadlineJSONList {
            Deadline.update(from: deadlineJSON, in: context)
        }
    }
    
    // MARK: - init
    init() {
        backgroundCheckTimerPublisher = Timer.TimerPublisher(interval: backgroundCheckTimeInterval, runLoop: .current, mode: .default)
        self.cancellable = backgroundCheckTimerPublisher
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { date in
                let accountValid = self.validateAccount()
                if accountValid {
                    self.lastConnectedToDeadlineTime = Date()
                }
            }
    }
}
