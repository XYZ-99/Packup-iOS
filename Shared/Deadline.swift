//
//  Deadline.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/23.
//

import CoreData

extension Deadline {
    var uid: Int {
        get {
            Int(uid_)
        }
        set {
            uid_ = Int64(newValue)
        }
    }
    
    var name: String {
        get {
            name_ ?? "Untitled"
        }
        set {
            name_ = newValue
        }
    }
    
    var deadlineDescription: String {
        get {
            deadlineDescription_ ?? "Unknown"
        }
        set {
            deadlineDescription_ = newValue
        }
    }
    
    var eventType: String {
        get {
            eventType_ ?? "Unknown type"
        }
        set {
            eventType_ = newValue
        }
    }
    
    var courseObjectID: String {
        get {
            courseObjectID_ ?? "Unknown ID"
        }
        set {
            courseObjectID_ = newValue
        }
    }
    
    var sourceName: String {
        get {
            sourceName_ ?? "Unknown source name"
        }
        set {
            sourceName_ = newValue
        }
    }
    
    
    func update(from deadlineJSON: DeadlineJSON) {
        uid = Int(deadlineJSON.itemSourceID.replacingOccurrences(of: "_", with: ""))!
        name = deadlineJSON.title
        deadlineDescription = deadlineJSON.calendarID
        eventType = deadlineJSON.eventType
        courseObjectID = deadlineJSON.itemSourceID
        sourceName = deadlineJSON.calendarName
        reminder = nil
        
        crawlUpdateTime = Date()
        let zuluDateFormatter = DateFormatter()
        zuluDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        zuluDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dueTime = zuluDateFormatter.date(from: deadlineJSON.endDate)
        syncTime = nil
        
        isCompleted = false
        hasBeenDeleted = false
        isStarred = false
        hasSubmission = false
    }
}
