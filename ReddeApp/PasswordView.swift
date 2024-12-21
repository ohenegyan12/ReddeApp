import SwiftUI

struct PasswordView: View {
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showAlert: Bool = false
    @State private var isPasswordFieldInvalid: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Back Button
                HStack {
                    Button(action: {
                        // Navigate back to the LoginSignup page
                        NavigationUtil.popToRootView()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 90)

                // Header Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome!")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Ohene Gyan")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("Enter your password to continue")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 50)

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
                        } else {
                            SecureField("Enter your password", text: $password)
                                .textContentType(.password)
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
                        // Handle forgot password action
                    }) {
                        Text("Forgot password")
                            .font(.subheadline)
                            .foregroundColor(Color.red)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)

                Spacer() // Pushes the button to the bottom

                // Log In Button
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
                .padding(.bottom, 20)
            }
            .background(Color.white)
            .ignoresSafeArea()
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Please enter your password.")
            }
        }
    }

    private func validatePassword() {
        if password.isEmpty {
            isPasswordFieldInvalid = true
            showAlert = true
        } else {
            isPasswordFieldInvalid = false
            // Navigate to the OTPView
        }
    }
}

struct OTP: View {
    var body: some View {
        VStack {
            Text("Enter OTP")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
        .padding()
    }
}

struct LoginSignup: View {
    var body: some View {
        VStack {
            Text("Login or Sign Up")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
        .padding()
    }
}

// Utility for Navigation
struct NavigationUtil {
    static func popToRootView() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else { return }
        rootViewController.dismiss(animated: true, completion: nil)
    }
}

// Custom Color Initializer for Hex
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

#Preview {
    PasswordView()
}
