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
                  predicate: NSPredicate(format: "isCompleted == false and isStarred == false"),
                  animation: Animation.linear(duration: 2)
    ) var deadlineList: FetchedResults<Deadline>
    
    @FetchRequest(entity: Deadline.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Deadline.dueTime, ascending: true)],
                  predicate: NSPredicate(format: "isStarred == true and isCompleted == false"),
                  animation: Animation.linear(duration: 2)
    ) var starredDeadlineList: FetchedResults<Deadline>
    
    @FetchRequest(entity: Deadline.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Deadline.dueTime, ascending: true)],
                  predicate: NSPredicate(format: "isCompleted == true"),
                  animation: Animation.linear(duration: 2)
    ) var completedDeadlineList: FetchedResults<Deadline>
    
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var packup: Packup
    
    @State var isShowingDeadlineDetails: Bool = false
    @State var syncing: Bool = false
    
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Image(systemName: "line.horizontal.3")
                    .padding(.leading)
                Text("Deadline")
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Inter-Regular", size: 20.0))
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
                
                Image(systemName: "line.horizontal.3.decrease")
                    .padding(.trailing)
            }
            .foregroundColor(.white)
            .background(
                Color("PackupBlue").edgesIgnoringSafeArea([.top, .leading, .trailing])
            )
            GeometryReader { geometry in
                List {
                    // TODO: transition
                    if starredDeadlineList.count > 0 {
                        ForEach(starredDeadlineList, id: \.uid) { deadline in
                            if deadline == starredDeadlineList.first {
                                Button(action: { isShowingDeadlineDetails = true }) {
                                    DeadlineView(deadline: deadline, hasCaption: true, caption: "Starred")
                                }.sheet(isPresented: $isShowingDeadlineDetails) {
                                    DeadlineDetailView(deadline: deadline, isShowingDeadlineDetails: $isShowingDeadlineDetails)
                                        .environment(\.managedObjectContext, context)
                                }
                                .listRowInsets(EdgeInsets())
                            } else {
                                Button(action: { isShowingDeadlineDetails = true }) {
                                    DeadlineView(deadline: deadline, hasCaption: false)
                                }.sheet(isPresented: $isShowingDeadlineDetails) {
                                    DeadlineDetailView(deadline: deadline, isShowingDeadlineDetails: $isShowingDeadlineDetails)
                                        .environment(\.managedObjectContext, context)
                                }
                                .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                    
                    if deadlineList.count > 0 {
                        ForEach(deadlineList, id: \.uid) { deadline in
                            if deadline == deadlineList.first {
                                Button(action: { isShowingDeadlineDetails = true }) {
                                    DeadlineView(deadline: deadline, hasCaption: true, caption: "Pending")
                                }.sheet(isPresented: $isShowingDeadlineDetails) {
                                    DeadlineDetailView(deadline: deadline, isShowingDeadlineDetails: $isShowingDeadlineDetails)
                                        .environment(\.managedObjectContext, context)
                                }
                                .listRowInsets(EdgeInsets())
                            } else {
                                Button(action: { isShowingDeadlineDetails = true }) {
                                    DeadlineView(deadline: deadline, hasCaption: false)
                                }.sheet(isPresented: $isShowingDeadlineDetails) {
                                    DeadlineDetailView(deadline: deadline, isShowingDeadlineDetails: $isShowingDeadlineDetails)
                                        .environment(\.managedObjectContext, context)
                                }
                                .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                    
                    if completedDeadlineList.count > 0 {
                        ForEach(completedDeadlineList, id: \.uid) { deadline in
                            if deadline == completedDeadlineList.first {
                                Button(action: { isShowingDeadlineDetails = true }) {
                                    DeadlineView(deadline: deadline, hasCaption: true, caption: "Completed")
                                }.sheet(isPresented: $isShowingDeadlineDetails) {
                                    DeadlineDetailView(deadline: deadline, isShowingDeadlineDetails: $isShowingDeadlineDetails)
                                        .environment(\.managedObjectContext, context)
                                }
                                .listRowInsets(EdgeInsets())
                            } else {
                                Button(action: { isShowingDeadlineDetails = true }) {
                                    DeadlineView(deadline: deadline, hasCaption: false)
                                }.sheet(isPresented: $isShowingDeadlineDetails) {
                                    DeadlineDetailView(deadline: deadline, isShowingDeadlineDetails: $isShowingDeadlineDetails)
                                        .environment(\.managedObjectContext, context)
                                }
                                .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                    
                    if starredDeadlineList.count == 0 &&
                        deadlineList.count == 0 &&
                        completedDeadlineList.count == 0 {
                        VStack {
                            Image("celebrateDay")
                                .resizable()
                                .scaledToFit()
                                .padding([.leading, .trailing], 70)
                            Text("Let's call it a day!")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    
                }
                .overlay(AddItem()
                            .position(x: geometry.size.width - 40.0, y: geometry.size.height - 40.0)
                )
            }
        }
    }
}

struct AddItem: View {
    var body: some View {
        Image(uiImage: UIImage(fluent: .add24Regular))
            .foregroundColor(.white)
            .background(Circle()
                            .foregroundColor(Color("PackupBlue"))
                            .scaleEffect(2.0)
            )
            .scaleEffect(1.2)
    }
}

//struct DeadlineListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeadlineListView()
//    }
//}
