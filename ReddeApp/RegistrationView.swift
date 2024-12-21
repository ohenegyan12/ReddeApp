import SwiftUI

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
                        .foregroundColor(.black) // Ensure title text is black
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Subtitle
                    Text("Join Redde Online and enjoy seamless transactions.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20)

                    // Form Fields
                    VStack(spacing: 15) {
                        // Email
                        CustomTextField(placeholder: "Email address", text: $email)

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

                        // Name
                        CustomTextField(placeholder: "Name", text: $name)

                        // Phone Number
                        CustomTextField(placeholder: "Phone number", text: $phoneNumber)

                        // Password
                        VStack {
                            ZStack(alignment: .trailing) {
                                if isPasswordVisible {
                                    TextField("Password", text: $password)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                                        .foregroundColor(.black) // Set text color to black
                                } else {
                                    SecureField("Password", text: $password)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                                        .foregroundColor(.black) // Set text color to black
                                }
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                                .offset(x: -10)
                            }
                        }

                        // Confirm Password
                        VStack {
                            ZStack(alignment: .trailing) {
                                if isConfirmPasswordVisible {
                                    TextField("Confirm password", text: $confirmPassword)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                                        .foregroundColor(.black) // Set text color to black
                                } else {
                                    SecureField("Confirm password", text: $confirmPassword)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                                        .foregroundColor(.black) // Set text color to black
                                }
                                Button(action: {
                                    isConfirmPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isConfirmPasswordVisible ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                                .offset(x: -10)
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Terms and Policies
                    VStack(alignment: .leading, spacing: 5) {
                        Text("By clicking Sign Up, you agree to our ")
                            .font(.footnote)
                            .foregroundColor(.gray)
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
                                .foregroundColor(.gray)
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
                                .foregroundColor(.gray)
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

                    // Removed Login Link for now
                    HStack {
                        Text("Already a member?")
                            .font(.footnote)
                        Text("Click here to login.")
                            .font(.footnote)
                            .foregroundColor(redColor)
                            .onTapGesture {
                                // Handle Login action or link when you're ready to re-implement it
                            }
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
            .background(Color.white) // Set the background color to white
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
    var placeholder: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray) // Set the placeholder color to gray
                    .padding(.leading, 10) // Optional padding to adjust the position of the placeholder
            }
            TextField("", text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .foregroundColor(.black) // Set text color to black
        }
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
