//
//  PackupMainView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/22.
//

import SwiftUI
import CoreData
import FluentIcons

struct PackupMainView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var packup: Packup
    
    var body: some View {
        TabView {
            DeadlineListView()
                .environment(\.managedObjectContext, context)
                .environmentObject(self.packup)
                .tabItem {
                    Image(systemName: "clock.fill")
            }.tag(1)
            Group {
                VStack(spacing: 0.0) {
                    HStack {
                        Image(systemName: "line.horizontal.3")
                            .padding(.leading)
                        Text("Events")
                            .multilineTextAlignment(.leading)
                            .font(Font.custom("Inter-Regular", size: 20.0))
                            .padding()
                        Spacer()
                        
                        Image(systemName: "line.horizontal.3.decrease")
                            .padding(.trailing)
                    }
                    .foregroundColor(.white)
                    .background(
                        Color("PackupBlue").edgesIgnoringSafeArea([.top, .leading, .trailing]).shadow(radius: 5)
                            
                    )
                    ZStack {
                        ScrollView {
                            
                        }
                        VStack {
                            Image(colorScheme == .light ? "celebrateDay" : "celebrateNight")
                                .resizable()
                                .scaledToFit()
                                .padding([.leading, .trailing], 70)
                            Text("Have a free day!")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    
                }
            }.tabItem {
                Image(systemName: "calendar")
            }.tag(2)
            Group {
                VStack(spacing: 0.0) {
                    HStack {
                        Image(systemName: "line.horizontal.3")
                            .padding(.leading)
                        Text("Files")
                            .multilineTextAlignment(.leading)
                            .font(Font.custom("Inter-Regular", size: 20.0))
                            .padding()
                        Spacer()
                        
                        Image(systemName: "line.horizontal.3.decrease")
                            .padding(.trailing)
                    }
                    .foregroundColor(.white)
                    .background(
                        Color("PackupBlue").edgesIgnoringSafeArea([.top, .leading, .trailing]).shadow(radius: 5)
                            
                    )
                    ZStack {
                        ScrollView {
                            
                        }
                        VStack {
                            Image(colorScheme == .light ? "cactusDay" : "cactusNight")
                                .resizable()
                                .scaledToFit()
                                .padding([.leading, .trailing], 70)
                            Text("No files yet!")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    
                }
            }.tabItem {
                Image(systemName: "folder")
            }.tag(3)
        }
//            .onAppear {
//                UITabBar.appearance().barTintColor = .white
//            }
        
    }
}

struct PackupMainView_Previews: PreviewProvider {
    static var previews: some View {
        PackupMainView()
    }
}
