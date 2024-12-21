import SwiftUI

struct OTPView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var otpCode: String = ""
    @State private var showError: Bool = false
    
    // Validation state
    @State private var isInputValid: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Back Button
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .imageScale(.large)
            }
            .padding(.top, 20)
            
            // Title
            Text("One Time Password")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 20)
            
            // Subtitle
            Text("To confirm your account, enter the OTP Code sent to your phone.")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .padding(.top, -10)
            
            // OTP TextField with validation styling
            TextField("OTP Code", text: $otpCode)
                .textInputAutocapitalization(.characters)
                .onChange(of: otpCode) { _ in
                    if !isInputValid {
                        isInputValid = true
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isInputValid ? Color.gray.opacity(0.3) : Color.red, lineWidth: 1)
                )
                .padding(.top, 20)
            
            // Error message
            if !isInputValid {
                Text("Please enter the OTP code")
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .padding(.top, -15)
            }
            
            // Resend Code Section
            HStack {
                Text("Didn't receive code?")
                    .foregroundColor(.gray)
                Button(action: {
                    // Handle resend action
                }) {
                    Text("Resent code")
                        .foregroundColor(.red)
                }
            }
            .padding(.top, 5)
            
            Spacer()
            
            // Submit Button
            Button(action: {
                validateAndSubmit()
            }) {
                Text("Submit")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color(red: 0.74, green: 0.04, blue: 0.06))
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal, 20)
        .navigationBarHidden(true)
        .alert("Invalid Input", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please enter the OTP code")
        }
    }
    
    private func validateAndSubmit() {
        if otpCode.isEmpty {
            isInputValid = false
            showError = true
            return
        }
        
        // Add your submission logic here
        // You can add additional validation for alpha/numeric/alphanumeric if needed
    }
}

// Preview
#Preview {
    OTPView()
}
