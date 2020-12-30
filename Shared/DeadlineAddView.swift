//
//  DeadlineAddView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/29.
//

import SwiftUI

struct DeadlineAddView: View {
    @State var newDeadlineName: String = ""
    @State var selectedDueTime: Date = Date()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Capsule()
                        .frame(width: 40, height: 7)
                        .foregroundColor(Color("TagBackgroundGray"))
                    
                    // TODO: change the color of the placeholder
                    // https://stackoverflow.com/questions/57688242/swiftui-how-to-change-the-placeholder-color-of-the-textfield
                    TextField("Title for a new deadline", text: $newDeadlineName)
                        .deadlineAddTextFieldStyle()
                        .padding([.top], 30)
                }
                .background(Color("PackupBlue")
                                .edgesIgnoringSafeArea(.top)
                )

                
                VStack {
                    HStack {
                        Image(systemName: "alarm")
                            .padding()
                        DatePicker(selection: $selectedDueTime,
                                   displayedComponents: [.hourAndMinute, .date]) {
                            Text("Due Time")
                                .font(.callout)
                        }
                        Spacer()
                    }
                    .foregroundColor(.gray)
                    
                    Divider()
                        .padding([.leading, .trailing])
                    
                    HStack {
                        Image(systemName: "bell")
                            .padding()
                        
                        Text("Setting a reminder")
                        Spacer()
                    }
                    .foregroundColor(.gray)
                    
                    Divider()
                        .padding([.leading, .trailing])
                    
                    HStack {
                        Image(systemName: "text.book.closed")
                            .padding()
                        Text("Link to a course")
                        Spacer()
                    }
                    .foregroundColor(.gray)
                    
                    Divider()
                        .padding([.leading, .trailing])
                    
                    HStack {
                        Image(systemName: "text.justifyleft")
                            .padding()
                        Text("Notes")
                        Spacer()
                    }
                    .foregroundColor(.gray)
                }
            }
            
        }
    }
}

struct DeadlineAddTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("DeadlineAddBackgroundGray"))
            .cornerRadius(5.0)
            .padding()
            .font(.title3)
            .foregroundColor(.white)
    }
}

extension View {
    func deadlineAddTextFieldStyle() -> some View {
        self.modifier(DeadlineAddTextFieldModifier())
    }
}

struct DeadlineAddView_Previews: PreviewProvider {
    static var previews: some View {
        DeadlineAddView()
    }
}
