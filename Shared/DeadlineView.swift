//
//  DeadlineView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/23.
//

import SwiftUI

struct DeadlineView: View {
    var body: some View {
        HStack() {
            Image(systemName: "square")
                .foregroundColor(.gray)
                .padding(.trailing)
                
            
            VStack(alignment: .leading,
                   spacing: 5.0) {
                Text("Lab 1 线程调度")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                
                HStack {
                    Image(systemName: "calendar")
                    Text("2020 年 10 月 01 日")
                }
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "folder")
                    Text("操作系统")
                }
                    .foregroundColor(.gray)
                
            }
            
            
            Spacer()
            Image(systemName: "checkmark")
                
            Image(systemName: "star")
        }
        .padding()
    }
}

struct DeadlineView_Previews: PreviewProvider {
    static var previews: some View {
        DeadlineView()
    }
}
