//
//  DeadlineDetailView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/13.
//

import SwiftUI
import CoreData

struct DeadlineDetailView: View {
    @State var sliderValue: Double = 0.0
    
    // TODO: set to false on save (maybe unnecessary)
    @State var modified: Bool = false
    
    var deadline: Deadline
    
    @Environment(\.managedObjectContext) var context
    
    @State var selectedReminderDate: Date
    
    let reminderDateRange: ClosedRange<Date>
    
    @Binding var isShowingDeadlineDetails: Bool
    
    @State var isShowingDeleteAlert: Bool = false
    
    init(deadline: Deadline, isShowingDeadlineDetails: Binding<Bool>) {
        self.deadline = deadline
        self._selectedReminderDate = State(wrappedValue: self.deadline.reminder ?? Date())
        let startDate = Date()
        self._isShowingDeadlineDetails = isShowingDeadlineDetails

        
        if let dueTime = deadline.dueTime, dueTime > startDate {
            let endDate = dueTime
            reminderDateRange = startDate...endDate
        } else {
            let endComponents = DateComponents(year: 2077, month: 12, day: 31)
            reminderDateRange = startDate...Calendar.current.date(from: endComponents)!
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack {
                    Capsule()
                        .frame(width: 40, height: 7)
                        .foregroundColor(Color("TagBackgroundGray"))
                        
                    
                    HStack {
                        Button(action: {
                            isShowingDeleteAlert = true
                        }) {
                            Text("Delete")
                                .foregroundColor(.red)
                        }
                        .padding(.leading)
                        .alert(isPresented: $isShowingDeleteAlert) {
                            Alert(title: Text("Delete this deadline?"),
                                  message: Text("This action cannot be undone."),
                                  primaryButton: .destructive(Text("Yes"), action: {
                                        // TODO: modify the hasBeenDeleted instead of actually deleting it
                                        context.delete(deadline)
                                        deadline.objectWillChange.send()
                                        
                                        do {
                                            try context.save()
                                        } catch {
                                            print("Unable to delete deadline in DeadlineDetailView!")
                                        }
                                        
                                        isShowingDeadlineDetails = false
                                  }),
                                  secondaryButton: .default(Text("No")))
                        }
                        
                        
                        Spacer()

                        Button(action: {
                            deadline.reminder = selectedReminderDate
                            deadline.objectWillChange.send()
                            
                            do {
                                try context.save()
                            } catch {
                                print("deadline.reminder does not save in DeadlineDetailView!")
                            }
                            
                            isShowingDeadlineDetails = false
                        }) {
                            Text("Confirm")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        .opacity(modified ? 1 : 0)
                        .animation(.easeInOut(duration: 0.2))
                        
                    }
                        
                    VStack(alignment: .leading, spacing: 0.0) {
                        HStack {
                            // TODO: Submitted
                            // FIXME: Customized deadlines have no submissions
                            if let dueTime = deadline.dueTime, dueTime > Date() {
                                Text("\(Date().daysLeftSinceNow(to: dueTime)) Days Left")
                                    .tagBackground(Color.red)
                                    .padding()
                            } else {
                                Text("Submitted")
                                    .tagBackground(Color.green)
                                    .padding()
                            }
                            
                            HStack {
                                Text(deadline.sourceName)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
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
                                Text("List")
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
                                Text("Description")
                                    .grayHeadline()
                                Spacer()
                            }
                            
                            HStack {
                                Text(deadline.deadlineDescription)
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
                            
                            DatePicker(selection: $selectedReminderDate, displayedComponents: [.hourAndMinute, .date]) {
                                Text("Reminder")
                                    .padding(.leading)
                                    .foregroundColor(.gray)
                            }
                            .onChange(of: selectedReminderDate, perform: { _ in
                                modified = true
                            })
                        }
                    }
                    
//                    Slider(value: $sliderValue, in: 1...100)
//                        .onChange(of: sliderValue, perform: { _ in
//                            modified = true
//                        })
//                        .padding()
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
        DeadlineDetailView(deadline: Deadline(), isShowingDeadlineDetails: Binding.constant(true))
    }
}
