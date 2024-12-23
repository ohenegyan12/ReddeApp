import SwiftUI

struct PasswordChangedView: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                // Key Image
                Image("key")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 144, height: 144)
                    .foregroundColor(Color(red: 0, green: 0.33, blue: 0.33))
                    
                // Main Title
                Text("Your password has been\nchanged successfully.")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                
                // Subtitle
                Text("You can login with new password.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .padding(.top, 8)
            }
            
            Spacer()
            
            // Login Button
            Button(action: {
                // Add login action here
            }) {
                Text("Go to Log in")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color(hex: "BD0910"))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .padding()
    }
}

// Preview Provider
struct PasswordChangedView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangedView()
    }
}
