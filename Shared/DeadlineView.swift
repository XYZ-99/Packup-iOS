//
//  DeadlineView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/23.
//

import SwiftUI

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
    var deadline: Deadline
    
//    var deadline = DeadlineJSON(testJSON, using: .utf8)!
    
    var body: some View {
        VStack {
            ZStack (alignment: Alignment(
                            horizontal: .leading,
                            vertical: .center
                        )
                    ) {
                Rectangle()
                    .frame(height: 30.0)
                    .foregroundColor(Color("TextFieldGray"))
                
                Text(deadline.sourceName)
                    .padding(.leading, 10.0)
                    .foregroundColor(.gray)
                    
            }
            
            HStack() {
                Image(systemName: "square")
                    .foregroundColor(.gray)
                    .padding(.trailing)
                    
                
                VStack(alignment: .leading,
                       spacing: 5.0) {
                    Text(deadline.name)
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                    
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
                Image(systemName: "checkmark")
                    
                Image(systemName: "star")
            }
            .padding()
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
