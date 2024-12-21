import SwiftUI

// MARK: - Password View
struct PasswordView: View {
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showAlert: Bool = false
    @State private var isPasswordFieldInvalid: Bool = false
    @State private var navigateToOTP = false
    @State private var showForgotPassword = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Back Button
                HStack {
                    Button(action: {
                        NavigationUtil.popToRootView()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)

                // Header Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("Ohene Gyan")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)

                    Text("Enter your password to continue")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)

                // Password Field Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)

                    HStack {
                        if isPasswordVisible {
                            TextField("Enter your password", text: $password)
                                .textContentType(.password)
                                .foregroundColor(.black)
                        } else {
                            SecureField("Enter your password", text: $password)
                                .textContentType(.password)
                                .foregroundColor(.black)
                        }

                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isPasswordFieldInvalid ? Color.red : Color.gray, lineWidth: 1)
                    )

                    Button(action: {
                        showForgotPassword = true
                    }) {
                        Text("Forgot password")
                            .font(.subheadline)
                            .foregroundColor(Color.red)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)

                Spacer()

                // Log In Button
                NavigationLink(
                    destination: OTPView(),
                    isActive: $navigateToOTP,
                    label: {
                        Button(action: {
                            validatePassword()
                        }) {
                            Text("Log in")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "BD0910"))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                )
            }
            .background(Color.white)
            .ignoresSafeArea()
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Please enter your password.")
            }
            .navigationDestination(isPresented: $showForgotPassword) {
                ForgotPasswordView()
            }
        }
    }

    private func validatePassword() {
        if password.isEmpty {
            isPasswordFieldInvalid = true
            showAlert = true
        } else {
            isPasswordFieldInvalid = false
            navigateToOTP = true
        }
    }
}

// MARK: - Success Alert View
struct SuccessAlert: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showLoginView: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Checkmark Circle
                ZStack {
                    Circle()
                        .fill(Color(red: 0/255, green: 71/255, blue: 58/255))
                        .frame(width: 80, height: 80)
                    
                    Circle()
                        .stroke(Color(red: 255/255, green: 183/255, blue: 3/255), lineWidth: 2)
                        .frame(width: 90, height: 90)
                    
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                }
                .padding(.top, 100)
                
                Text("All done")
                    .font(.system(size: 34, weight: .bold))
                    .padding(.top, 20)
                
                Text("A new password has been sent to you via\nyour registered channels")
                    .font(.system(size: 17))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button(action: {
                    showLoginView = true
                }) {
                    Text("Continue")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color(hex: "BD0910"))
                        .cornerRadius(28)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            .background(Color.white)
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
}

// MARK: - Forgot Password View
struct ForgotPassword: View {
    @State private var phoneNumber: String = ""
    @Environment(\.dismiss) private var dismiss
    @State private var navigateToOTP = false
    @Environment(\.presentationMode) var presentationMode
    @State private var showSuccessAlert = false
    @State private var showLoginView = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                // Back Button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)
                
                // Header Section
                Text("Forgot password")
                    .font(.system(size: 34, weight: .bold))
                    .padding(.top, 24)
                    .padding(.horizontal, 20)
                
                Text("Please enter your phone number to get verification code.")
                    .font(.system(size: 17))
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
                    .padding(.horizontal, 20)
                
                // Phone Number Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone Number")
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.top, 32)
                    
                    TextField("", text: $phoneNumber)
                        .font(.system(size: 17))
                        .keyboardType(.numberPad)
                        .onChange(of: phoneNumber) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered.count > 10 {
                                phoneNumber = String(filtered.prefix(10))
                            } else {
                                phoneNumber = filtered
                            }
                        }
                        .padding(.top, 8)
                    
                    Divider()
                        .background(Color.gray.opacity(0.3))
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    if phoneNumber.count == 10 {
                        showSuccessAlert = true
                    }
                }) {
                    Text("Continue")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(phoneNumber.count == 10 ? Color(hex: "BD0910") : Color.gray)
                        .cornerRadius(28)
                }
                .disabled(phoneNumber.count != 10)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            .background(Color.white)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $showSuccessAlert) {
                SuccessAlertView(showLoginView: $showLoginView)
            }
            .navigationDestination(isPresented: $showLoginView) {
                PasswordView()
            }
        }
    }
}

// MARK: - OTP View
struct OTP: View {
    var body: some View {
        VStack {
            Text("Enter OTP")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
        }
        .padding()
    }
}

// MARK: - Navigation Utility
struct NavigationUtil {
    static func popToRootView() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else { return }
        rootViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var int: UInt64 = 0
        scanner.scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
    }
}
