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
    
    
    var Deadlines = [
        DeadlineJSON(testJSON, using: .utf8)!
    ]
    
    var body: some View {
        VStack {
            ZStack (alignment: Alignment(
                            horizontal: .leading,
                            vertical: .center
                        )
                    ) {
                Rectangle()
                    .frame(height: 30.0)
                    .foregroundColor(Color(white: 0.95))
                
                Text(Deadlines[0].calendarName)
                    .padding(.leading, 10.0)
                    .foregroundColor(.gray)
                    
            }
            
            HStack() {
                Image(systemName: "square")
                    .foregroundColor(.gray)
                    .padding(.trailing)
                    
                
                VStack(alignment: .leading,
                       spacing: 5.0) {
                    Text(Deadlines[0].title)
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text(Deadlines[0].endDate)
                    }
                        .foregroundColor(.gray)
                    
                    HStack {
                        Image(systemName: "folder")
                        Text(Deadlines[0].calendarName)
                    }
                        .foregroundColor(.gray)
                    
                }
                
                
                Spacer()
                Image(systemName: "checkmark")
                    
                Image(systemName: "star")
            }
            .padding()
        }
    }
}

struct DeadlineView_Previews: PreviewProvider {
    static var previews: some View {
        DeadlineView()
    }
}
