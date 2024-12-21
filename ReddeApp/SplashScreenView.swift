import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var opacity = 0.5
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 0.8
    
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
                    .rotationEffect(.degrees(rotation))
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.opacity = 1.0
                        }
                        
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            self.rotation = 360
                        }
                        
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            self.scale = 1.2
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
}

#Preview {
    SplashScreenView()
}
