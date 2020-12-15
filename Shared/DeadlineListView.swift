//
//  DeadlineView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/23.
//

import SwiftUI
import CoreData

struct DeadlineListView: View {
    @FetchRequest(entity: Deadline.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Deadline.dueTime, ascending: true)],
                  predicate: NSPredicate(format: "isCompleted == false"),
                  animation: Animation.linear(duration: 0.3)
    ) var deadlineList: FetchedResults<Deadline>
    
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var packup: Packup
    
    @State var isShowingDeadlineDetails: Bool = false
    @State var syncing: Bool = false
    
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Text("Packup")
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Inter-Bold", size: 25.0))
                    .padding()
                Spacer()
                // TODO: Sync with the course
                Button(action: {
                    syncing = true
                    DispatchQueue.global(qos: .userInteractive).async {
                        // TODO: Notify on failure
                        // TODO: Log out manually
                        packup.fetchCourseDeadlineAndUpdate(context: context) // lastConnectedToDeadlineTime will help invalidate
                        syncing = false
                    }
                }) {
                    // TODO: Come up with a more natural way to do it!
                    ZStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .rotationEffect(Angle(degrees: syncing ? 450.0 : 90.0))
                            .animation(.linear(duration: 1.0))
                            .padding()
                            .opacity(syncing ? 1 : 0)
                        
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .rotationEffect(Angle(degrees: 90.0))
                            .padding()
                            .opacity(syncing ? 0 : 1)
                    }
                }
            }
            .foregroundColor(.white)
            .background(
                Color("PackupBlue").edgesIgnoringSafeArea([.top, .leading, .trailing])
            )
            
            List {
                // TODO: transition
                ForEach(deadlineList, id: \.uid) { deadline in
                    Button(action: { isShowingDeadlineDetails = true }) {
                        DeadlineView(deadline: deadline)
                            .transition(.scale)
                    }.sheet(isPresented: $isShowingDeadlineDetails) {
                        DeadlineDetailView(deadline: deadline)
                    }
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
