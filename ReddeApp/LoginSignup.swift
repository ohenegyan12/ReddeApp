import SwiftUI

struct LoginSignupView: View {
    @State private var email: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // Red Section
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 150) // Increased height of the red section

                // Tagline Text Only
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

                // Email Text Field (Accepting Only Emails)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.top, 5)

                // Next Button
                Button(action: {
                    // Handle Next button action
                }) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.74, green: 0.04, blue: 0.06)) // Match red section color
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)

            Spacer()

            // Sign-Up Section
            HStack {
                Text("New to Redde?")
                    .foregroundColor(.gray)
                Button(action: {
                    // Handle create account action
                }) {
                    Text("Create an account")
                        .foregroundColor(.red)
                }
            }
            .padding(.bottom, 30)
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

// Preview
#Preview {
    LoginSignupView()
}
