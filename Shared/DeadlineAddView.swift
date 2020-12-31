//
//  DeadlineAddView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/29.
//

import SwiftUI

struct DeadlineAddView: View {
    @Binding var isAddingDeadline: Bool
    
    @State var newDeadlineName: String = ""
    @State var selectedDueTime: Date = Date()
    @State var modified: Bool = false
    
    @Environment(\.managedObjectContext) var context
    
    @State var deadlineDescription: String = ""
    
    // TODO: logically this should not be attached to DeadlineAddView
    // and should be a Set or something
    static var deadlineuid: Int64 = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Capsule()
                        .frame(width: 40, height: 7)
                        .foregroundColor(Color("TagBackgroundGray"))
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            // add a new deadline
                            let deadline: Deadline = Deadline(context: context)
                            deadline.name = newDeadlineName
                            deadline.hasSubmission = false
                            deadline.isCompleted = false
                            deadline.isStarred = false
                            deadline.hasBeenDeleted = false
                            deadline.sourceName = "Default" // TODO: Folder
                            deadline.uid_ = DeadlineAddView.deadlineuid
                            DeadlineAddView.deadlineuid += 1
                            deadline.dueTime = selectedDueTime
                            if deadlineDescription.count > 0 {
                                deadline.deadlineDescription = deadlineDescription
                            }
                            
                            deadline.objectWillChange.send()
                            
                            do {
                                try context.save()
                            } catch {
                                print("context cannot save in DeadlineAddView")
                            }
                            
                            isAddingDeadline = false
                        }) {
                            Text("Confirm")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        .opacity(modified ? 1 : 0)
                        .animation(.easeInOut(duration: 0.2))
                    }
                    
                    // TODO: Test dark mode
                    DeadlineAddTextField(placeholder: Text("Something to do...")
                                            .foregroundColor(Color("DeadlineAddPlaceholderGray"))
                                            .font(.title3)
                                            .fontWeight(.bold),
                                         text: $newDeadlineName,
                                         onCommit: { modified = true })
                }
                .padding(.top, 10)
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
                    
                    ZStack(alignment: .top) {
                        TextEditor(text: $deadlineDescription)
                            .disableAutocorrection(true)
                            .padding([.leading, .trailing])
                            .padding(.top, 5)
                        if deadlineDescription.count == 0 {
                            HStack {
                                Image(systemName: "text.justifyleft")
                                    .padding()
                                Text("Notes")
                                Spacer()
                            }
                        }
                    }
                    .foregroundColor(.gray)
                }
            }
            
        }
    }
}

struct DeadlineAddTextField: View {
    var placeholder: Text
    @Binding var text: String
    var onEditingChanged: (Bool)->() = { _ in }
    var onCommit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder.padding(.leading, 35) }
            TextField("", text: $text, onEditingChanged: onEditingChanged, onCommit: onCommit)
                .deadlineAddTextFieldStyle()
                .disableAutocorrection(true)
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

//struct DeadlineAddView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeadlineAddView()
//    }
//}
