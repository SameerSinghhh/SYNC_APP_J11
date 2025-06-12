//
//  SocialLoginView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI

struct SocialLoginView: View {
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    @State private var buttonPressed: String? = nil
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Same beautiful animated background
            // Base gradient layer
            LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.4, blue: 0.9),
                    Color(red: 0.1, green: 0.6, blue: 0.8),
                    Color(red: 0.3, green: 0.5, blue: 0.8)
                ],
                startPoint: animateGradient1 ? .topLeading : .bottomTrailing,
                endPoint: animateGradient1 ? .bottomTrailing : .topLeading
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                    animateGradient1.toggle()
                }
            }
            
            // Second gradient layer
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.7, blue: 0.6).opacity(0.7),
                    Color(red: 0.4, green: 0.3, blue: 0.9).opacity(0.7),
                    Color(red: 0.2, green: 0.8, blue: 0.7).opacity(0.7)
                ],
                startPoint: animateGradient2 ? .topTrailing : .bottomLeading,
                endPoint: animateGradient2 ? .bottomLeading : .topTrailing
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                    animateGradient2.toggle()
                }
            }
            
            // Third gradient layer
            RadialGradient(
                colors: [
                    Color(red: 0.3, green: 0.4, blue: 0.8).opacity(0.4),
                    Color.clear
                ],
                center: animateGradient3 ? .topLeading : .bottomTrailing,
                startRadius: 50,
                endRadius: 400
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                    animateGradient3.toggle()
                }
            }
            
            // Floating particles
            ForEach(0..<12, id: \.self) { index in
                FloatingParticle(delay: Double(index) * 0.35)
            }
            
            VStack(spacing: 0) {
                // Top section with logo and back button
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.2))
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    )
                            )
                    }
                    
                    Spacer()
                    
                    // SYNC Logo in top area
                    HStack(spacing: 8) {
                        // Mini sync icon
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width: 24, height: 24)
                            
                            Path { path in
                                let center = CGPoint(x: 12, y: 12)
                                let radius: CGFloat = 8
                                path.addArc(center: center, radius: radius, startAngle: .degrees(-45), endAngle: .degrees(135), clockwise: false)
                            }
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                            .frame(width: 24, height: 24)
                            
                            Path { path in
                                let center = CGPoint(x: 12, y: 12)
                                let radius: CGFloat = 8
                                path.addArc(center: center, radius: radius, startAngle: .degrees(135), endAngle: .degrees(315), clockwise: false)
                            }
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                            .frame(width: 24, height: 24)
                        }
                        
                        Text("SYNC")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    // Invisible spacer for balance
                    Color.clear
                        .frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                Spacer()
                
                // Main content
                VStack(spacing: 40) {
                    // Header section
                    VStack(spacing: 16) {
                        Text("Choose Your Way")
                            .font(.system(size: 32, weight: .thin, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Connect with your favorite platform")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                    }
                    
                    // Social login options
                    VStack(spacing: 16) {
                        // Apple Sign In
                        SocialLoginButton(
                            title: "Continue with Apple",
                            icon: "apple.logo",
                            backgroundColor: Color.black.opacity(0.8),
                            isPressed: buttonPressed == "apple"
                        ) {
                            handleSocialLogin(provider: "apple")
                        }
                        
                        // Google Sign In
                        SocialLoginButton(
                            title: "Continue with Google",
                            icon: "globe",
                            backgroundColor: Color.white.opacity(0.9),
                            textColor: .black,
                            isPressed: buttonPressed == "google"
                        ) {
                            handleSocialLogin(provider: "google")
                        }
                        
                        // Facebook Sign In
                        SocialLoginButton(
                            title: "Continue with Facebook",
                            icon: "f.square.fill",
                            backgroundColor: Color.blue.opacity(0.8),
                            isPressed: buttonPressed == "facebook"
                        ) {
                            handleSocialLogin(provider: "facebook")
                        }
                        
                        // Twitter/X Sign In
                        SocialLoginButton(
                            title: "Continue with X",
                            icon: "x.circle.fill",
                            backgroundColor: Color.gray.opacity(0.8),
                            isPressed: buttonPressed == "twitter"
                        ) {
                            handleSocialLogin(provider: "twitter")
                        }
                        
                        // Discord Sign In
                        SocialLoginButton(
                            title: "Continue with Discord",
                            icon: "gamecontroller.fill",
                            backgroundColor: Color.purple.opacity(0.8),
                            isPressed: buttonPressed == "discord"
                        ) {
                            handleSocialLogin(provider: "discord")
                        }
                        
                        // Spotify Sign In
                        SocialLoginButton(
                            title: "Continue with Spotify",
                            icon: "music.note.list",
                            backgroundColor: Color.green.opacity(0.8),
                            isPressed: buttonPressed == "spotify"
                        ) {
                            handleSocialLogin(provider: "spotify")
                        }
                    }
                    .padding(.horizontal, 32)
                }
                
                Spacer()
                
                // Bottom section with privacy note
                VStack(spacing: 16) {
                    HStack {
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                        
                        Text("secure")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal, 16)
                        
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 32)
                    
                    VStack(spacing: 8) {
                        HStack(spacing: 6) {
                            Image(systemName: "shield.checkered")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text("Your data is protected and secure")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        Text("We never store your social media passwords")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.white.opacity(0.6))
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
    }
    
    private func handleSocialLogin(provider: String) {
        // Animate button press
        withAnimation(.spring(response: 0.2, dampingFraction: 0.6)) {
            buttonPressed = provider
        }
        
        // Reset animation and handle login
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            buttonPressed = nil
            print("Social login with \(provider)")
            // Handle actual social login logic here
        }
    }
}

struct SocialLoginButton: View {
    let title: String
    let icon: String
    let backgroundColor: Color
    let textColor: Color
    let isPressed: Bool
    let action: () -> Void
    
    init(title: String, icon: String, backgroundColor: Color, textColor: Color = .white, isPressed: Bool, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.isPressed = isPressed
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(textColor)
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(textColor)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .animation(.spring(response: 0.2, dampingFraction: 0.6), value: isPressed)
    }
}

#Preview {
    SocialLoginView()
} 