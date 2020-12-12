//
//  LoginView.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/11.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var packup: Packup
    
    @State var studentID: String = ""
    @State var password: String = ""
    
    @State var blocking = false
    
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
                SecureField("Password", text: $password)
                    .loginTextFieldStyle()
                Button(action: {
                    packup.studentID = studentID
                    packup.password = password
                    blocking = true
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        accountValid = packup.validateAccount()
                        DispatchQueue.main.async {
                            blocking = false
                        }
                    }
                }) {
                    RoundedRectangle(cornerRadius: 3)
                        .frame(maxHeight: 50)
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
            }
            .offset(y: geometry.size.height / 8)
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
            .background(Color.lightGray)
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
