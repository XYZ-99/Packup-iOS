//
//  DeadlineView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/23.
//

import SwiftUI

struct DeadlineListView: View {
    @FetchRequest(entity: Deadline.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Deadline.dueTime, ascending: true)]
    ) var deadlineList: FetchedResults<Deadline>
    
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
                Button(action: {
                    syncing = true
                    DispatchQueue.global(qos: .userInteractive).async {
                        sleep(1)
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
                ForEach(deadlineList, id: \.uid) { deadline in
                    Button(action: { isShowingDeadlineDetails = true }) {
                        DeadlineView(deadline: deadline)
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
