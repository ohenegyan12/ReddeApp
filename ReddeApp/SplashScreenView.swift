import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            OnboardingView()
        } else {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .opacity(opacity)
            }
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.opacity = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

// Add this preview provider at the bottom of your file
#Preview {
    SplashScreenView()
}
