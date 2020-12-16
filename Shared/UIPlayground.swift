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
        
        ScrollView {
            
            Text("Starred")
                .foregroundColor(.gray)
                .padding()
                .background(Color("TextFieldGray").frame(height: 30))
                .frame(width: .infinity)
//                .listRowInsets(EdgeInsets())
            Text("Hello")
        }
    }
}

struct UIPlayground_Previews: PreviewProvider {
    static var previews: some View {
        UIPlayground()
    }
}
