//
//  LoginView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI

struct LoginView: View {
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    @State private var phoneNumber = ""
    @State private var selectedCountryCode = "+1"
    @State private var showCountryPicker = false
    @State private var loginButtonPressed = false
    @State private var showSocialLogin = false
    @Environment(\.dismiss) private var dismiss
    
    let countryCodes = [
        ("+1", "🇺🇸", "US"),
        ("+44", "🇬🇧", "UK"),
        ("+91", "🇮🇳", "IN"),
        ("+86", "🇨🇳", "CN"),
        ("+81", "🇯🇵", "JP"),
        ("+49", "🇩🇪", "DE"),
        ("+33", "🇫🇷", "FR"),
        ("+39", "🇮🇹", "IT"),
        ("+34", "🇪🇸", "ES"),
        ("+61", "🇦🇺", "AU")
    ]
    
    var body: some View {
        ZStack {
            // Same beautiful animated background as homepage
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
            ForEach(0..<10, id: \.self) { index in
                FloatingParticle(delay: Double(index) * 0.4)
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
                VStack(spacing: 32) {
                    // Welcome message
                    VStack(spacing: 12) {
                        Text("Welcome Back")
                            .font(.system(size: 32, weight: .thin, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Sign in to sync your world")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    // Form container
                    VStack(spacing: 24) {
                        // Phone number input section
                        VStack(spacing: 16) {
                            // Country code and phone number row
                            HStack(spacing: 12) {
                                // Country code picker
                                Button(action: {
                                    showCountryPicker.toggle()
                                }) {
                                    HStack(spacing: 8) {
                                        Text(countryCodes.first(where: { $0.0 == selectedCountryCode })?.1 ?? "🇺🇸")
                                            .font(.system(size: 20))
                                        
                                        Text(selectedCountryCode)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Image(systemName: "chevron.down")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.white.opacity(0.2))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                            )
                                    )
                                }
                                .actionSheet(isPresented: $showCountryPicker) {
                                    ActionSheet(
                                        title: Text("Select Country"),
                                        buttons: countryCodes.map { code in
                                            .default(Text("\(code.1) \(code.2) \(code.0)")) {
                                                selectedCountryCode = code.0
                                            }
                                        } + [.cancel()]
                                    )
                                }
                                
                                // Phone number input
                                TextField("Phone Number", text: $phoneNumber)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .placeholder(when: phoneNumber.isEmpty) {
                                        Text("Phone Number")
                                            .foregroundColor(.white.opacity(0.6))
                                            .font(.system(size: 16, weight: .medium))
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.white.opacity(0.2))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                            )
                                    )
                                    .keyboardType(.phonePad)
                            }
                            
                            // Information text
                            Text("We'll send a verification code to this number")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.white.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                        }
                        
                        // Send code button
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                loginButtonPressed.toggle()
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                loginButtonPressed = false
                            }
                            
                            // Handle send verification code
                            print("Send verification code to \(selectedCountryCode)\(phoneNumber)")
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "paperplane.fill")
                                    .font(.system(size: 18, weight: .medium))
                                
                                Text("Send Verification Code")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 28)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color.white.opacity(0.3),
                                                Color.white.opacity(0.2)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 28)
                                            .stroke(Color.white.opacity(0.4), lineWidth: 1)
                                    )
                            )
                            .scaleEffect(loginButtonPressed ? 0.95 : 1.0)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                        .disabled(phoneNumber.isEmpty)
                        .opacity(phoneNumber.isEmpty ? 0.6 : 1.0)
                    }
                    .padding(.horizontal, 32)
                }
                
                Spacer()
                
                // Alternative options
                VStack(spacing: 16) {
                    HStack {
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                        
                        Text("or")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal, 16)
                        
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 32)
                    
                    Button(action: {
                        // Handle social sign in
                        print("Social sign in tapped")
                        showSocialLogin = true
                    }) {
                        NavigationLink(destination: SocialLoginView(), isActive: $showSocialLogin) {
                            HStack(spacing: 12) {
                                Image(systemName: "person.2.fill")
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text("Continue with Social")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .foregroundColor(.white.opacity(0.9))
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.white.opacity(0.15))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    )
                            )
                        }
                    }
                    .padding(.horizontal, 32)
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
    }
}

// Extension for placeholder text
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    LoginView()
} 