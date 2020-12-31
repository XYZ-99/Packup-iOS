//
//  SwitchView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/12.
//

import SwiftUI
import CoreData

struct SwitchView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var packup: Packup
    
    // an @State is necessary here to notify the UI on the first launch
    @State var accountValid: Bool = false
    
    var infoExpired: Bool {
        get {
            packup.infoExpired
        }
        set {
            if newValue == true {
                // Already expired
                accountValid = false
            }
        }
    }
    
    var body: some View {
        Group {
            if !accountValid && infoExpired {
                LoginView(accountValid: $accountValid)
                    .environmentObject(self.packup)
                    .animation(.easeInOut(duration: 1))
            } else {
                PackupMainView()
                    .environmentObject(self.packup)
            }
        }
    }
}

struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchView()
            .environmentObject(Packup())
    }
}
