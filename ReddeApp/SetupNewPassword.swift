import SwiftUI

struct SetupNewPasswordView: View {
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var isCurrentPasswordVisible: Bool = false
    @State private var isNewPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Back Arrow
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .padding(.bottom)
                }

                // Header
                Text("Set up new password")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Password must be 8 - 20 characters with at least 1 number, 1 letter and 1 special symbol.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)

                // Current Password Field
                PasswordField(
                    title: "Current Password",
                    text: $currentPassword,
                    isPasswordVisible: $isCurrentPasswordVisible
                )

                // New Password Field
                PasswordField(
                    title: "New Password",
                    text: $newPassword,
                    isPasswordVisible: $isNewPasswordVisible
                )

                // Confirm Password Field
                PasswordField(
                    title: "Confirm Password",
                    text: $confirmPassword,
                    isPasswordVisible: $isConfirmPasswordVisible
                )

                Spacer()

                // Change Password Button
                Button(action: {
                    // Handle change password logic here
                }) {
                    Text("Change Password")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
            .padding()
            .navigationBarHidden(true) // Hides the default navigation bar
        }
    }
}

struct PasswordField: View {
    let title: String
    @Binding var text: String
    @Binding var isPasswordVisible: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)

            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                if isPasswordVisible {
                    TextField(title, text: $text)
                        .textContentType(.password)
                        .autocapitalization(.none)
                        .foregroundColor(.black)
                } else {
                    SecureField(title, text: $text)
                        .textContentType(.password)
                        .autocapitalization(.none)
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
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
        }
    }
}

struct SetupNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SetupNewPasswordView()
    }
}
