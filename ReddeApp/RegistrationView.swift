import SwiftUI

// Extension for placeholder functionality
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct Registration: View {
    @State private var email = ""
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var accountType = "Personal"
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var showError = false

    let redColor = Color(red: 189 / 255, green: 9 / 255, blue: 16 / 255) // #BD0910

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    Text("Create Your Account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
 
                    // Subtitle
                    Text("Join Redde Online and enjoy seamless transactions.")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20)

                    // Form Fields
                    VStack(spacing: 15) {
                        // Email
                        CustomTextField(text: $email, placeholder: "Email address")
                           
                        // Account Type
                        Text("Account Type")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)

                        HStack(spacing: 20) {
                            RadioButton(text: "Personal", isSelected: accountType == "Personal") {
                                accountType = "Personal"
                            }
                            RadioButton(text: "Company", isSelected: accountType == "Company") {
                                accountType = "Company"
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        // Name and Phone
                        CustomTextField(text: $name, placeholder: "Name")
                        CustomTextField(text: $phoneNumber, placeholder: "Phone number")
                        
                        // Password fields
                        CustomSecureField(text: $password,
                                        placeholder: "Password",
                                        isVisible: $isPasswordVisible)
                        
                        CustomSecureField(text: $confirmPassword,
                                        placeholder: "Confirm password",
                                        isVisible: $isConfirmPasswordVisible)
                    }
                    .padding(.horizontal)

                    // Terms and Policies
                    VStack(alignment: .leading, spacing: 5) {
                        Text("By clicking Sign Up, you agree to our ")
                            .font(.footnote)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        HStack(spacing: 3) {
                            Text("Terms of use")
                                .font(.footnote)
                                .foregroundColor(redColor)
                                .underline()
                                .onTapGesture {
                                    // Handle Terms of Use link
                                }
                            Text("and that you have read our ")
                                .font(.footnote)
                                .foregroundColor(.black)
                            Text("Retention Policy")
                                .font(.footnote)
                                .foregroundColor(redColor)
                                .underline()
                                .onTapGesture {
                                    // Handle Retention Policy link
                                }
                        }
                        HStack(spacing: 3) {
                            Text(", including our ")
                                .font(.footnote)
                                .foregroundColor(.black)
                            Text("Anti-Money Laundering Policy")
                                .font(.footnote)
                                .foregroundColor(redColor)
                                .underline()
                                .onTapGesture {
                                    // Handle Anti-Money Laundering Policy link
                                }
                        }
                    }
                    .padding(.top, 10)

                    // Sign Up Button
                    Button(action: {
                        validateForm()
                    }) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(redColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)

                    // Login Link
                    HStack {
                        Text("Already a member?")
                            .font(.footnote)
                            .foregroundColor(.black)
                        Text("Click here to login.")
                            .font(.footnote)
                            .foregroundColor(redColor)
                            .onTapGesture {
                                // Handle Login action
                            }
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
            .background(Color.white)
            .alert(isPresented: $showError) {
                Alert(
                    title: Text("Missing Fields"),
                    message: Text("Please fill in all required fields."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func validateForm() {
        if email.isEmpty || name.isEmpty || phoneNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            showError = true
        } else if password != confirmPassword {
            showError = true
        } else {
            // Proceed with sign up logic here
        }
    }
}

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        TextField("", text: $text)
            .placeholder(when: text.isEmpty) {
                Text(placeholder)
                    .foregroundColor(.black.opacity(0.6))
            }
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .frame(height: 50)
    }
}

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: String
    @Binding var isVisible: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isVisible {
                TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .foregroundColor(.black.opacity(0.6))
                    }
            } else {
                SecureField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .foregroundColor(.black.opacity(0.6))
                    }
            }
            
            Button(action: {
                isVisible.toggle()
            }) {
                Image(systemName: isVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 10)
        }
        .foregroundColor(.black)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
        .frame(height: 50)
    }
}

struct RadioButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Circle()
                    .stroke(isSelected ? Color(red: 189 / 255, green: 9 / 255, blue: 16 / 255) : Color.gray, lineWidth: 2)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .fill(isSelected ? Color(red: 189 / 255, green: 9 / 255, blue: 16 / 255) : Color.clear)
                            .frame(width: 10, height: 10)
                    )
                Text(text)
                    .foregroundColor(.black)
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
    }
}
