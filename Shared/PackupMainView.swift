//
//  TodoList.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/22.
//

import SwiftUI

struct PackupMainView: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            DeadlineListView().tabItem {
                Image(systemName: "clock.fill")
            }.tag(1)
            Text("Tab Content 2").tabItem {
                Image(systemName: "calendar")
            }.tag(2)
            Text("Tab Content 3").tabItem {
                Image(systemName: "folder")
            }.tag(3)
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        PackupMainView()
    }
}
