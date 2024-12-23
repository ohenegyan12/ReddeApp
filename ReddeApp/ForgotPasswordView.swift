import SwiftUI

struct SuccessAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showLoginView: Bool
    
    var body: some View {
        VStack(spacing: 20) {
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
                .foregroundColor(.black)
                .padding(.top, 20)
            
            Text("A new password has been sent to you via\nyour registered channels")
                .font(.system(size: 17))
                .foregroundColor(.black)
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

struct ForgotPasswordView: View {
    @State private var phoneNumber: String = ""
    @State private var showSuccessAlert = false
    @State private var showLoginView = false
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Button(action: {
                    // Dismiss action
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)
                
                Text("Forgot password")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                
                Text("Please enter your phone number to get verification code.")
                    .font(.system(size: 17))
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone Number")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)
                    
                    TextField("Enter your phone number", text: $phoneNumber)
                        .font(.system(size: 17))
                        .keyboardType(.numberPad)
                        .padding(.top, 8)
                        .onChange(of: phoneNumber) { newValue in
                            phoneNumber = String(newValue.prefix(10).filter("0123456789".contains))
                        }
                    
                    Divider()
                        .background(Color.gray.opacity(0.3))
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
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
                .padding(.bottom, keyboardHeight > 0 ? 16 : 40)
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
            .onAppear {
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
