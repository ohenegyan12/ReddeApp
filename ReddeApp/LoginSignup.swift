import SwiftUI

struct LoginSignupView: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var isEmailValid: Bool = true
    @State private var navigateToOTP = false
    @State private var navigateToRegistration = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Red Section
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 150)
                    
                    Text("Empowering Your Finances,\nOne Tap at a Time")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(6)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 0.74, green: 0.04, blue: 0.06))
                
                // White Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Log In to Your Account")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Access your Redde Online App.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isEmailValid ? Color.gray : Color.red, lineWidth: 1)
                        )
                        .padding(.top, 5)
                    
                    Button(action: {
                        if isValidEmail(email) {
                            navigateToOTP = true
                        } else {
                            isEmailValid = false
                            showAlert = true
                        }
                    }) {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.74, green: 0.04, blue: 0.06))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
                
                Spacer()
                
                HStack {
                    Text("New to Redde?")
                        .foregroundColor(.gray)
                    Button(action: {
                        navigateToRegistration = true
                    }) {
                        Text("Create an account")
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 30)
            }
            .background(Color.white)
            .ignoresSafeArea()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Email"),
                    message: Text("Please enter a valid email address."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(isPresented: $navigateToOTP) {
                PasswordView()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $navigateToRegistration) {
                Registration()
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

struct RegistrationView: View {
    var body: some View {
        Text("Registration Page")
            .font(.title)
            .padding()
    }
}

#Preview {
    LoginSignupView()
}
