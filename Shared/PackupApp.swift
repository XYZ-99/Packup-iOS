//
//  PackupApp.swift
//  Shared
//
//  Created by Yinzhen Xu on 2020/11/22.
//

import SwiftUI

@main
struct PackupApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
