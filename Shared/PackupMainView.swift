//
//  PackupMainView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/22.
//

import SwiftUI
import CoreData
import FluentIcons

struct PackupMainView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var packup: Packup
    
    var body: some View {
        TabView {
            DeadlineListView()
                .environment(\.managedObjectContext, context)
                .environmentObject(self.packup)
                .tabItem {
                    Image(systemName: "clock.fill")
            }.tag(1)
            Text("Tab Content 2").tabItem {
                Image(systemName: "calendar")
            }.tag(2)
            Text("Tab Content 3").tabItem {
                Image(systemName: "folder")
            }.tag(3)
        }
//            .onAppear {
//                UITabBar.appearance().barTintColor = .white
//            }
        
    }
}

struct PackupMainView_Previews: PreviewProvider {
    static var previews: some View {
        PackupMainView()
    }
}
