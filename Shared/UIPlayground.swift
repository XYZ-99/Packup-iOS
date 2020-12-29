//
//  UIPlayground.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/12.
//

import SwiftUI
import FluentIcons

struct UIPlayground: View {
    @State var disappear: Bool = false;
    @State var present: Bool = false
    
    @State var testToggle: Bool = false {
        didSet {
            if testToggle {
                disappear = true;
            } else {
                disappear = false;
            }
        }
    }
    
    var body: some View {

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

struct UIPlayground_Previews: PreviewProvider {
    static var previews: some View {
        UIPlayground()
    }
}
