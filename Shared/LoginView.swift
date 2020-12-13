//
//  LoginView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/11.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var packup: Packup
    
    @State var studentID: String = ""
    @State var password: String = ""
    
    @State var blocking = false
    @State var showLoginFailedAlert = false
    
    @Binding var accountValid: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Packup")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { dimension in
                        geometry.size.width / 2 - 5 // 5 is the padding
                    })
                TextField("Student ID", text: $studentID)
                    .loginTextFieldStyle()
                    .disableAutocorrection(true)
                SecureField("Password", text: $password)
                    .loginTextFieldStyle()
                Button(action: {
                    packup.studentID = studentID
                    packup.password = password
                    blocking = true
                    
                    DispatchQueue.global(qos: .userInteractive).async {
                        accountValid = packup.validateAccount()
                        DispatchQueue.main.async {
                            blocking = false
                            if !accountValid {
                                showLoginFailedAlert = true
                            }
                        }
                        if accountValid {
                            packup.fetchCourseDeadlineAndUpdate(context: context)
                        }
                    }
                }) {
                    RoundedRectangle(cornerRadius: 3)
                        .frame(minHeight: 50, maxHeight: 55)
                        .padding()
                        .foregroundColor(Color("PackupRed"))
                        .overlay(
                            Group {
                                if !blocking {
                                    Text("Log In")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                } else {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                }
                            }
                        )
                }
                .alert(isPresented: $showLoginFailedAlert) {
                    Alert(title: Text("Login Failed"),
                          message: Text("Please check your network, studend ID, or password."),
                          dismissButton: .default(Text("OK")))
                }
            }
            .offset(y: geometry.size.height / 8 - 10)
        }
    }
}

extension Color {
    static let lightGray = Color(UIColor(white: CGFloat(0.95), alpha: CGFloat(1.0)))
}

struct LoginTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("TextFieldGray"))
            .cornerRadius(5.0)
            .padding()
    }
}

extension View {
    func loginTextFieldStyle() -> some View {
        self.modifier(LoginTextFieldModifier())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(accountValid: Binding.constant(false))
            .environmentObject(Packup())
    }
}
