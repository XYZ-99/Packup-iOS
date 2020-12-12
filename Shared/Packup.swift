//
//  Packup.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/11.
//

import Foundation

class Packup: ObservableObject {
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
    
    var deadlineFetcher: DeadlineFetcher = DeadlineFetcher()
    var lastConnectedTime: Date?
    
    func validateAccount() -> Bool {
        deadlineFetcher.validateAccount(studentID: studentID, password: password)
    }
}
