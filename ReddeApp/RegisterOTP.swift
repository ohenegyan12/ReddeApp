//
//  RegisterOTP.swift
//  ReddeApp
//
//  Created by OGK on 23/12/2024.
//

import SwiftUI

struct RegisterOTP: View {
    @State private var emailCode: String = ""
    @State private var mobileCode: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Title Section
            VStack(alignment: .leading, spacing: 8) {
                Text("One Time\nPasswords")
                    .font(.system(size: 34, weight: .bold))
                    .padding(.top, 40)
                
                Text("Enter Verification codes to continue")
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 32)
            
            // Email Verification Section
            VStack(alignment: .leading, spacing: 16) {
                Text("Enter Email Verification Code")
                    .font(.system(size: 17))
                
                TextField("ABCD", text: $emailCode)
                    .font(.system(size: 17))
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.bottom, 8)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                
                HStack {
                    Spacer()
                    Button(action: {
                        // Resend email code action
                    }) {
                        Text("Resend code")
                            .foregroundColor(Color(hex: "BD0910"))
                    }
                }
            }
            .padding(.bottom, 24)
            
            // Mobile Verification Section
            VStack(alignment: .leading, spacing: 16) {
                Text("Enter Mobile Verification Code")
                    .font(.system(size: 17))
                
                TextField("ABCD", text: $mobileCode)
                    .font(.system(size: 17))
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.bottom, 8)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                
                HStack {
                    Spacer()
                    Button(action: {
                        // Resend mobile code action
                    }) {
                        Text("Resend code")
                            .foregroundColor(Color(hex: "BD0910"))
                    }
                }
            }
            
            Spacer()
            
            // Login Button
            Button(action: {
                // Login action
            }) {
                Text("Log in")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color(hex: "BD0910"))
                    .cornerRadius(12)
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
    }
}

struct OneTimePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterOTP()
    }
}
