//
//  OnboardingView.swift
//  ReddeApp
//
//  Created by OGK on 20/12/2024.
//

import SwiftUI

// First, create a model for our onboarding data
struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
    let buttonText: String
}

// Create our OnboardingView
struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var isOnboardingComplete = false
    
    // Adjustable image height
    private let imageHeight: CGFloat = 250
    
    let pages = [
        OnboardingPage(
            title: "Welcome to Redde Online",
            description: "Your trusted platform for seamless online transactions.",
            imageName: "onboarding1",
            buttonText: "Next"
        ),
        OnboardingPage(
            title: "Fast & Secure Payments",
            description: "Send money, pay merchants, and settle bills with confidence using our trusted payment gateways.",
            imageName: "onboarding2",
            buttonText: "Next"
        ),
        OnboardingPage(
            title: "Stay in Control",
            description: "Monitor payments, get real-time notifications, and stay updated on all your transactions.",
            imageName: "onboarding3",
            buttonText: "Get Started"
        )
    ]
    
    var body: some View {
        if isOnboardingComplete {
            LoginSignupView() 
        } else {
            ZStack {
                
                Color(red: 0.74, green: 0.04, blue: 0.06) //
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        if currentPage < 2 {
                            Button("Skip") {
                                currentPage = 2 // Skip to last page
                            }
                            .foregroundColor(.white)
                            .padding()
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text(pages[currentPage].title)
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(pages[currentPage].description)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Image(pages[currentPage].imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: imageHeight)
                        .padding(.bottom, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        if currentPage == 2 {
                            isOnboardingComplete = true
                            
                        } else {
                            currentPage += 1
                        }
                    }) {
                        Text(pages[currentPage].buttonText)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color(red: 0.74, green: 0.04, blue: 0.06))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
    }
}


#Preview {
    OnboardingView()
}
