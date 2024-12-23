import SwiftUI

struct OneTimePasswordView: View {
    @State private var otpCode: String = ""
    @State private var showAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(spacing: 8) {
                Text("One Time Password")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("To confirm your account, enter the OTP Code sent to your phone.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            TextField("OTP Code", text: $otpCode)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 50)  // Increased height
                .padding(.horizontal)
            
            HStack {
                Text("Didn't receive code?")
                    .foregroundColor(.gray)
                Button("Resent code") {
                    // Resend action here
                }
                .foregroundColor(.red)
            }
            
            Spacer()
            
            Button(action: validateOTP) {
                Text("Submit")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Invalid Code"),
                message: Text("Please enter a valid OTP code"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func validateOTP() {
        guard !otpCode.isEmpty else {
            showAlert = true
            return
        }
    }
}

#Preview {
    OneTimePasswordView()
}
