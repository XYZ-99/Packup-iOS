//
//  DeadlineView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/23.
//

import SwiftUI

struct DeadlineListView: View {
    var body: some View {
        VStack(spacing: 0.0) {
            ZStack {
                Rectangle()
                    .foregroundColor(.accentColor)
                    
                HStack {
                    Text("Packup")
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("Inter-Bold", size: 25.0))
                        .padding()
                    Spacer()
                    Image(systemName: "pencil")
                        .padding()
                }
                .foregroundColor(.white)
//                    .padding(.trailing, 250.0)
                .padding(.top, 90.0)
            }
            .frame(height: 50.0)
            .ignoresSafeArea(.all, edges: .top)
            

            ScrollView {
                DeadlineView()
                    
            }
        
            
        }
    }
}

struct DeadlineListView_Previews: PreviewProvider {
    static var previews: some View {
        DeadlineListView()
    }
}
