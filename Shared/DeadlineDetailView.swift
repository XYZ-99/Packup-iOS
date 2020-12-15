//
//  DeadlineDetailView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/13.
//

import SwiftUI

// TODO: Cancel, Done <- @Binding isShowingDeadlineDetails
// TODO: Pass the context to this view
// TODO: Save any changes to the deadline <- no need for functions if changes are limited to dates and reminders <- pass the deadline pls
// TODO: Truncate the course String(or use truncate)
struct DeadlineDetailView: View {
    @State var sliderValue: Double = 0.0
    
    // TODO: set to false on save
    @State var modified: Bool = false
    
    var deadline: Deadline
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack {
                    Capsule()
                        .frame(width: 40, height: 7)
                        .foregroundColor(Color("TagBackgroundGray"))
                        
                    
                    HStack {
                        Spacer()

                        Button(action: {}) {
                            Text("Confirm")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        .opacity(modified ? 1 : 0)
                        .animation(.easeInOut(duration: 0.2))
                        
                    }
                        
                    VStack(alignment: .leading, spacing: 0.0) {
                        HStack {
                            // TODO: submitted
                            if let dueTime = deadline.dueTime {
                                Text("\(Date().daysLeftSinceNow(to: dueTime)) Days Left")
                                    .tagBackground(Color.red)
                                    .padding()
                            }
                            
                            HStack {
                                Text(deadline.sourceName)
                                    .lineLimit(1)
                                    .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                                Image(systemName: "chevron.right")
                            }
                            .tagBackground(Color("TagBackgroundGray"))
                        }
                        
                        
                        HStack {
                            Text(deadline.name)
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
                                Text(deadline.sourceName)
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
                                DefaultGrayNoneText(deadline.dueTime?.toPackupFormatString())
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
                                DefaultGrayNoneText(deadline.reminder?.toPackupFormatString())
                                    .padding([.leading, .trailing, .bottom])
                                Spacer()
                            }
                        }
                    }
                    
                    Slider(value: $sliderValue, in: 1...100)
                        .onChange(of: sliderValue, perform: { value in
                            modified = true
                        })
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

extension Date {
    static let secondsPerDay: Int = 86400
    
    func daysLeftSinceNow(to dueTime: Date) -> Int {
        return -1 * (Int(self.timeIntervalSince(dueTime)) / (Self.secondsPerDay))
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

struct DefaultGrayNoneText: View {
    let text: String?
    
    init(_ content: String?) {
        self.text = content
    }
    
    var body: some View {
        if let text = text {
            Text(text)
        } else {
            Text("None")
                .foregroundColor(.gray)
        }
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
        DeadlineDetailView(deadline: Deadline())
    }
}
