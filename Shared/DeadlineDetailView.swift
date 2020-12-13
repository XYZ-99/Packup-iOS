//
//  DeadlineDetailView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/13.
//

import SwiftUI

struct DeadlineDetailView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    Color("AccentColor")
                        .frame(height: geometry.size.height / 4)
                    
                    VStack(alignment: .leading, spacing: 0.0) {
                        HStack {
                            Text("Lab4 Virtual Memory")
                                .font(.title)
                                .fontWeight(.semibold)
                                
                                
                            Spacer()
                            Image(systemName: "star")
                        }
                        .padding([.leading, .bottom, .trailing])
                        
                        Text("2020 Fall")
                        .padding([.leading, .bottom, .trailing])
                        
                    }
                    .foregroundColor(.white)
                        
                }
                .ignoresSafeArea(/*@START_MENU_TOKEN@*/.container/*@END_MENU_TOKEN@*/, edges: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 8)
                
                VStack() {
                    HStack {
                        Text("Starts from")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                        
                    HStack {
                        Text("2020-12-02 13:00")
                            .padding([.leading, .trailing, .bottom])
                        Spacer()
                    }
                    
                    HStack {
                        Text("Ends at")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                    
                    HStack {
                        Text("2020-12-08 23:00")
                            .padding([.leading, .trailing, .bottom])
                        Spacer()
                    }
                    
                    Spacer()
                    
                }
                .padding()
                .frame(minWidth: geometry.size.width, minHeight: 3 * geometry.size.height / 4)
                    
            }
        }
    }
}

struct DeadlineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeadlineDetailView()
    }
}
