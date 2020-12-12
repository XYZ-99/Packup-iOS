//
//  SwitchView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/12.
//

import SwiftUI

struct SwitchView: View {
    @State var accountValid: Bool = false
    @State var infoExpired: Bool = true
    
//    @EnvironmentObject var packup: Packup
    
    var body: some View {
        if !accountValid && infoExpired {
            LoginView(accountValid: $accountValid)
//                .environmentObject(self.packup)
        } else {
            PackupMainView()
        }
    }
}

struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchView()
    }
}
