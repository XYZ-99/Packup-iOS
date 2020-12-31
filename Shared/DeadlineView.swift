//
//  DeadlineView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/23.
//

import SwiftUI
import CoreData

let testJSON = """
{
    "gradable": false,
    "allDay": false,
    "itemSourceType": "blackboard.platform.gradebook2.GradableItem",
    "itemSourceId": "_149309_1",
    "userCreated": false,
    "repeat": false,
    "calendarId": "048-04834260-0006161023-1",
    "recur": false,
    "color": "#008850",
    "calendarName": "操作系统(20-21学年第1学期)",
    "editable": false,
    "isUltraEvent": false,
    "calendarNameLocalizable": {
        "rawValue": "操作系统(20-21学年第1学期)"
    },
    "disableResizing": true,
    "attemptable": true,
    "isDateRangeLimited": false,
    "id": "_blackboard.platform.gradebook2.GradableItem-_149309_1",
    "start": "2020-12-09T23:59:00",
    "end": "2020-12-09T23:59:00",
    "location": null,
    "title": "Lab4 虚拟内存",
    "startDate": "2020-12-09T15:59:00.000Z",
    "endDate": "2020-12-09T15:59:00.000Z",
    "eventType": "作业"
}
"""

struct DeadlineView: View {
    @Environment(\.managedObjectContext) var context
    var deadline: Deadline
    var hasCaption: Bool
    var caption: String
    var isStarred: Bool
    var isCompleted: Bool
    
    init(deadline: Deadline, hasCaption: Bool = false, caption: String = "") {
        self.deadline = deadline
        self.hasCaption = hasCaption
        self.caption = caption
        
        self.isStarred = deadline.isStarred
        self.isCompleted = deadline.isCompleted
    }
    
//    var deadline = DeadlineJSON(testJSON, using: .utf8)!
    
    var body: some View {
        VStack {
            if hasCaption {
                ZStack (alignment: Alignment(
                                horizontal: .leading,
                                vertical: .center
                            )
                        ) {
                    Rectangle()
                        .frame(height: 30.0)
                        .foregroundColor(Color("TextFieldGray"))
                    
                    Text(caption)
                        .padding(.leading, 10.0)
                        .foregroundColor(.gray)
                        
                }
            }
            
            // TODO: prune this lengthy code
            if !isCompleted {
                HStack() {
                    Button(action: {
                        deadline.isCompleted = !isCompleted
                        deadline.objectWillChange.send()
                        
                        do {
                            try context.save()
                        } catch {
                            print("Unable to save deadline isCompleted in DeadlineView!")
                        }
                    }){
                        Image(systemName: "square")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                        
                    
                    VStack(alignment: .leading,
                           spacing: 5.0) {
                        Text(deadline.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            
                        
                        Label(
                            title: { Text(deadline.dueTime?.toPackupFormatString() ?? "") },
                            icon: { Image(systemName: "calendar") }
                        )
                        .foregroundColor(.gray)
                        .alignmentGuide(.leading, computeValue: { dimension in
                            5
                        })
                        
                        
                        Label(
                            title: { Text(deadline.sourceName) },
                            icon: { Image(systemName: "folder") }
                        )
                        .foregroundColor(.gray)
                        .alignmentGuide(.leading, computeValue: { dimension in
                            5
                        })
                    }
                    
                    
                    Spacer()
                    
    //                Image(systemName: "checkmark")
                    
                    Button(action: {
                        deadline.isStarred = !isStarred
                        deadline.objectWillChange.send()
                        
                        do {
                            try context.save()
                        } catch {
                            print("starred deadline unsaved in DeadlineView!")
                        }
                    }) {
                        if isStarred {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding()
            } else {
                HStack() {
                    Button(action: {
                        deadline.isCompleted = !isCompleted
                        deadline.objectWillChange.send()
                        
                        do {
                            try context.save()
                        } catch {
                            print("Unable to save deadline isCompleted in DeadlineView!")
                        }
                    }){
//                        Image(systemName: "square")
//                            .overlay(Image(systemName: "checkmark").scaleEffect(1.2).offset(y: -5))
                        Image(systemName: "checkmark.square.fill")
                            .padding(.trailing)
                    }
                        
                    
                    VStack(alignment: .leading,
                           spacing: 5.0) {
                        Text(deadline.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            
                        
                        Label(
                            title: { Text(deadline.dueTime?.toPackupFormatString() ?? "") },
                            icon: { Image(systemName: "calendar") }
                        )
                        .foregroundColor(.gray)
                        .alignmentGuide(.leading, computeValue: { dimension in
                            5
                        })
                        
                        
                        Label(
                            title: { Text(deadline.sourceName) },
                            icon: { Image(systemName: "folder") }
                        )
                        .foregroundColor(.gray)
                        .alignmentGuide(.leading, computeValue: { dimension in
                            5
                        })
                    }
                    
                    
                    Spacer()
                    
    //                Image(systemName: "checkmark")
                    
                    Button(action: {
                        deadline.isStarred = !isStarred
                        deadline.objectWillChange.send()
                        
                        do {
                            try context.save()
                        } catch {
                            print("starred deadline unsaved in DeadlineView!")
                        }
                    }) {
                        if isStarred {
                            Image(systemName: "star.fill")
                        } else {
                            Image(systemName: "star")
                        }
                    }
                }
                .padding()
                .foregroundColor(.gray)
            }
        }
    }
}

extension Date {
    func toPackupFormatString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
}

//struct DeadlineView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeadlineView()
//    }
//}
