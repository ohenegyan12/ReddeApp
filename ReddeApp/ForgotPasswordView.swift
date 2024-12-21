import SwiftUI

struct SuccessAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showLoginView: Bool
    
    var body: some View {
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
            
            // Text
            Text("All done")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.black) // Set text color to black
                .padding(.top, 20)
            
            Text("A new password has been sent to you via\nyour registered channels")
                .font(.system(size: 17))
                .foregroundColor(.black) // Set text color to black
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // Continue Button
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

struct ForgotPasswordView: View {
    @State private var phoneNumber: String = ""
    @Environment(\.dismiss) private var dismiss
    @State private var navigateToOTP = false
    @Environment(\.presentationMode) var presentationMode
    @State private var showSuccessAlert = false
    @State private var showLoginView = false
    @State private var keyboardHeight: CGFloat = 0
    
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
                    .foregroundColor(.black) // Set text color to black
                    .padding(.top, 24)
                    .padding(.horizontal, 20)
                
                Text("Please enter your phone number to get verification code.")
                    .font(.system(size: 17))
                    .foregroundColor(.black) // Set text color to black
                    .padding(.top, 8)
                    .padding(.horizontal, 20)
                
                // Phone Number Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone Number")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black) // Set text color to black
                        .padding(.top, 32)
                    
                    TextField("", text: $phoneNumber)
                        .font(.system(size: 17))
                        .keyboardType(.numberPad)
                        .foregroundColor(.black) // Set text color to black
                        .onChange(of: phoneNumber) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered.count > 10 {
                                phoneNumber = String(filtered.prefix(10))
                            } else {
                                phoneNumber = filtered
                            }
                        }
                        .padding(.top, 8)
                        .onSubmit {
                            // Dismiss the keyboard when the user finishes entering the phone number
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .submitLabel(.done)  // Suggests a "Done" button on the keyboard (iOS 15+)
                    
                    Divider()
                        .background(Color.gray.opacity(0.3))
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Adjust the "Continue" button position based on the keyboard height
                GeometryReader { geometry in
                    VStack {
                        Spacer()
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
                                .cornerRadius(10)
                        }
                        .disabled(phoneNumber.count != 10)
                        .padding(.horizontal, 20)
                        .padding(.bottom, keyboardHeight > 0 ? (geometry.safeAreaInsets.bottom + 16) : 40)
                    }
                }
            }
            .background(Color.white)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $showSuccessAlert) {
                SuccessAlertView(showLoginView: $showLoginView)
            }
            .navigationDestination(isPresented: $showLoginView) {
                PasswordView() // Make sure PasswordView is defined
            }
            .onAppear {
                // Observe keyboard notifications to adjust the button's position
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        keyboardHeight = keyboardFrame.height
                    }
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    keyboardHeight = 0
                }
            }
        }
    }
}

// Preview
struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
