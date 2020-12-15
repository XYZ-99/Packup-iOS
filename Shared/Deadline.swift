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
    
    // TODO: Distinguish the update from the course(e.g., dueTime, submission, etc.), and update from the user(e.g., deleted, starred, etc.)
    @discardableResult
    static func update(from deadlineJSON: DeadlineJSON, in context: NSManagedObjectContext) -> Deadline {
        let request = NSFetchRequest<Deadline>(entityName: "Deadline")
        request.predicate = NSPredicate(format: "name_ = %@", deadlineJSON.title)
        request.sortDescriptors = [NSSortDescriptor(key: "dueTime", ascending: true)]
        let results = (try? context.fetch(request)) ?? []
        let deadline = results.first ?? Deadline(context: context)
        
        deadline.uid = Int(deadlineJSON.itemSourceID.replacingOccurrences(of: "_", with: ""))!
        deadline.name = deadlineJSON.title
        deadline.deadlineDescription = deadlineJSON.calendarID
        deadline.eventType = deadlineJSON.eventType
        deadline.courseObjectID = deadlineJSON.itemSourceID
        deadline.sourceName = deadlineJSON.calendarName
        deadline.reminder = nil
        
        deadline.crawlUpdateTime = Date()
        let zuluDateFormatter = DateFormatter()
        zuluDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        zuluDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        deadline.dueTime = zuluDateFormatter.date(from: deadlineJSON.endDate)
        deadline.syncTime = nil
        
        deadline.isCompleted = false
        deadline.hasBeenDeleted = false
        deadline.isStarred = false
        deadline.hasSubmission = false
        
        deadline.objectWillChange.send()
        
        do {
            try context.save()
        } catch {
            print("Deadline not saving in Deadline.update!")
        }
        
        return deadline
    }
}
