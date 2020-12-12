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
    let packup: Packup = Packup()

    var body: some Scene {
        WindowGroup {
            SwitchView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(packup)
        }
    }
}
