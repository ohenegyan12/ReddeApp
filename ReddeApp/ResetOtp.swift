import SwiftUI

struct OTPCodeView: View {
    @State private var otpCode: String = ""
    @State private var isResending: Bool = false
    @State private var showAlert: Bool = false
    @State private var message: String = ""
    @State private var isInputValid: Bool = true

    var body: some View {
        VStack {
            // Back Button and Title
            HStack {
                Button(action: {
                    // Action for back button
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.top)

            // Title and Description
            VStack(alignment: .leading, spacing: 10) { // Align to the left
                Text("One Time Password")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)

                Text("To confirm your account, enter the OTP Code sent to your phone.")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading) // Left-align the subtitle
                    .padding(.horizontal, 30)
            }
            .padding(.top, 30) // Push title down a bit for spacing

            // OTP Input Field with placeholder
            ZStack(alignment: .leading) {
                if otpCode.isEmpty {
                    Text("OTP Code")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                }

                TextField("", text: $otpCode)
                    .textInputAutocapitalization(.characters)
                    .foregroundColor(.black)
                    .onChange(of: otpCode) { _ in
                        if !isInputValid {
                            isInputValid = true
                        }
                    }
                    .padding()
                    .keyboardType(.numberPad)
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isInputValid ? Color.gray.opacity(0.3) : Color.red, lineWidth: 1)
            )
            .padding(.horizontal, 40)
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

                Spacer()

                Button(action: resendCode) {
                    Text(isResending ? "Resending..." : "Resend code")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .bold()
                }
                .disabled(isResending)
            }
            .padding(.horizontal, 40)
            .padding(.top, 10)

            Spacer(minLength: 30) // Adds space between the resend section and submit button

            // Submit Button
            Button(action: submitCode) {
                Text("Submit")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color(red: 0.74, green: 0.04, blue: 0.06))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .padding(.bottom, 20)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notification"), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }

    // MARK: - Actions
    func resendCode() {
        isResending = true
        message = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isResending = false
            message = "OTP has been resent to your phone."
            showAlert = true
        }
    }

    func submitCode() {
        if otpCode.isEmpty {
            isInputValid = false
            message = "Please enter the OTP."
            showAlert = true
        } else {
            message = "OTP submitted successfully!"
            showAlert = true
        }
    }
}

struct OTPCodeView_Previews: PreviewProvider {
    static var previews: some View {
        OTPCodeView()
    }
}
