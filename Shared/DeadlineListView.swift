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
            ZStack {
                Rectangle()
                    .foregroundColor(.accentColor)
                    
                HStack {
                    Text("Packup")
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("Inter-Bold", size: 25.0))
                        .padding()
                    Spacer()
                    Image(systemName: "pencil")
                        .padding()
                }
                .foregroundColor(.white)
//                    .padding(.trailing, 250.0)
                .padding(.top, 90.0)
            }
            .frame(height: 50.0)
            .ignoresSafeArea(.all, edges: .top)
            

            ScrollView {
                ForEach(deadlineList, id: \.uid) { deadline in
                    DeadlineView(deadline: deadline)
                }
//                DeadlineView(deadline: deadlineList[0])
//                DeadlineView(deadline: deadlineList[1])
//                DeadlineView(deadline: deadlineList[2])
            }
        }
    }
}

struct DeadlineListView_Previews: PreviewProvider {
    static var previews: some View {
        DeadlineListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
