//
//  DeadlineDetailView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/13.
//

import SwiftUI

struct DeadlineDetailView: View {
    @State var sliderValue: Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack {
                    Capsule()
                        .frame(width: 40, height: 7)
                        .foregroundColor(Color("TagBackgroundGray"))
                        
                    VStack(alignment: .leading, spacing: 0.0) {
                        HStack {
                            Text("3 Days Remaining")
                                .tagBackground(Color.red)
                                .padding()
                            
                            HStack {
                                Text("Operating System")
                                Image(systemName: "chevron.right")
                            }
                            .tagBackground(Color("TagBackgroundGray"))
                        }
                        
                        
                        HStack {
                            Text("Lab4 Virtual Memory")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            Image(systemName: "star")
                        }
                        .padding([.leading, .bottom, .trailing])
                    }
                    .foregroundColor(.white)
                }
                .padding(.top, 10)
                .background(
                    Color("PackupBlue").edgesIgnoringSafeArea(.top)
                )

                VStack() {
                    Group {
                        Group {
                            HStack {
                                Text("Description")
                                    .grayHeadline()
                                Spacer()
                            }
                                
                            HStack {
                                Text("Still not the penultimate lab of this semester. And this description is very long.")
                                    .padding([.leading, .trailing, .bottom])
                                Spacer()
                            }
                        }
                        
                        Group {
                            HStack {
                                Text("Due Time")
                                    .grayHeadline()
                                Spacer()
                            }
                            
                            HStack {
                                Text("2020-12-08 23:00")
                                    .padding([.leading, .trailing, .bottom])
                                Spacer()
                            }
                        }
                        
                        Group {
                            HStack {
                                Text("Reminder")
                                    .grayHeadline()
                                Spacer()
                            }
                            
                            HStack {
                                Text("2020-12-08 23:00")
                                    .padding([.leading, .trailing, .bottom])
                                Spacer()
                            }
                        }
                    }
                    
                    Slider(value: $sliderValue, in: 1...100)
                        .padding()
                    Divider()
                    HStack {
                        Text("Attachments")
                            .grayHeadline()
                        Spacer()
                    }
                    
                    Spacer()
                    
                }
                .padding([.leading, .trailing, .top])
                .frame(minWidth: geometry.size.width, minHeight: 3 * geometry.size.height / 4)
            }
        }
    }
}

struct TagBackgroundModifier: ViewModifier {
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding(5)
            .padding([.leading, .trailing], 5)
            .background(backgroundColor.cornerRadius(5))
    }
}

extension View {
    func tagBackground(_ backgroundColor: Color) -> some View {
        self.modifier(TagBackgroundModifier(backgroundColor: backgroundColor))
    }
}

struct GrayHeadlineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.gray)
            .padding([.top, .bottom])
    }
}

extension View {
    func grayHeadline() -> some View {
        self.modifier(GrayHeadlineModifier())
    }
}

struct DeadlineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeadlineDetailView()
    }
}
