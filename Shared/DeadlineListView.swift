//
//  DeadlineView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/23.
//

import SwiftUI

// TODO: Pass context to me!
struct DeadlineListView: View {
    @FetchRequest(entity: Deadline.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Deadline.dueTime, ascending: true)]
    ) var deadlineList: FetchedResults<Deadline>
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Text("Packup")
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Inter-Bold", size: 25.0))
                    .padding()
                Spacer()
                Image(systemName: "arrow.triangle.2.circlepath")
                    .rotationEffect(Angle(degrees: 90))
                    .padding()
            }
            .foregroundColor(.white)
            .padding(.top, 20)
            .background(
                Color("AccentColor").edgesIgnoringSafeArea(.top)
            )
            
            List {
                ForEach(deadlineList, id: \.uid) { deadline in
                    DeadlineView(deadline: deadline)
                        .listRowInsets(EdgeInsets())
                }
            }
        }
    }
}

//struct DeadlineListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeadlineListView()
//    }
//}
