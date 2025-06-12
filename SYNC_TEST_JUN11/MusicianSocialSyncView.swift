//
//  MusicianSocialSyncView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI

struct MusicianSocialSyncView: View {
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    @State private var connectedPlatforms: Set<String> = []
    @State private var continueButtonPressed = false
    @State private var skipButtonPressed = false
    @State private var navigateToUpload = false
    @Environment(\.dismiss) private var dismiss
    
    let socialPlatforms = [
        SocialPlatform(id: "instagram", name: "Instagram", icon: "camera.fill", color: Color.pink, description: "Share photos and stories"),
        SocialPlatform(id: "spotify", name: "Spotify", icon: "music.note", color: Color.green, description: "Stream and share music"),
        SocialPlatform(id: "soundcloud", name: "SoundCloud", icon: "waveform", color: Color.orange, description: "Upload and share tracks"),
        SocialPlatform(id: "youtube", name: "YouTube", icon: "play.rectangle.fill", color: Color.red, description: "Share music videos"),
        SocialPlatform(id: "tiktok", name: "TikTok", icon: "music.quarternote.3", color: Color.black, description: "Create viral content"),
        SocialPlatform(id: "applemusic", name: "Apple Music", icon: "music.note.list", color: Color.red, description: "Stream on Apple's platform"),
        SocialPlatform(id: "twitter", name: "X (Twitter)", icon: "x.circle.fill", color: Color.gray, description: "Connect with fans"),
        SocialPlatform(id: "facebook", name: "Facebook", icon: "f.square.fill", color: Color.blue, description: "Build your community"),
        SocialPlatform(id: "bandcamp", name: "Bandcamp", icon: "opticaldisc", color: Color.cyan, description: "Sell your music directly")
    ]
    
    var body: some View {
        ZStack {
            // Same beautiful cool tone animated background
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
            ForEach(0..<8, id: \.self) { index in
                FloatingParticle(delay: Double(index) * 0.4)
            }
            
            ScrollView {
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
                        
                        // Progress indicator (step 2 of 5)
                        HStack(spacing: 4) {
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 8, height: 8)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 8, height: 8)
                            
                            ForEach(0..<3, id: \.self) { _ in
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 8, height: 8)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Main content
                    VStack(spacing: 32) {
                        // Header
                        VStack(spacing: 16) {
                            Text("Connect Your Platforms")
                                .font(.system(size: 28, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Link your social media and music platforms to showcase your work")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                        }
                        .padding(.top, 20)
                        
                        // Connected platforms count
                        if !connectedPlatforms.isEmpty {
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text("\(connectedPlatforms.count) platform\(connectedPlatforms.count == 1 ? "" : "s") connected")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.15))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                    )
                            )
                        }
                        
                        // Social platforms grid
                        VStack(spacing: 16) {
                            ForEach(socialPlatforms, id: \.id) { platform in
                                SocialPlatformCard(
                                    platform: platform,
                                    isConnected: connectedPlatforms.contains(platform.id)
                                ) {
                                    togglePlatformConnection(platform.id)
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                        
                        // Action buttons
                        VStack(spacing: 16) {
                            // Continue Button
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    continueButtonPressed.toggle()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    continueButtonPressed = false
                                    navigateToUpload = true
                                }
                                
                                // Handle continue to next step
                                print("Social sync completed - Connected platforms: \(connectedPlatforms)")
                            }) {
                                HStack(spacing: 12) {
                                    Text("Continue")
                                        .font(.system(size: 18, weight: .semibold))
                                    
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 16, weight: .medium))
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
                                .scaleEffect(continueButtonPressed ? 0.95 : 1.0)
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                            }
                            
                            // Skip Button
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    skipButtonPressed.toggle()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    skipButtonPressed = false
                                }
                                
                                // Handle skip
                                print("Social sync skipped")
                            }) {
                                Text("Skip for now")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                                    .underline()
                            }
                            .scaleEffect(skipButtonPressed ? 0.95 : 1.0)
                        }
                        .padding(.horizontal, 32)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToUpload) {
            MusicianUploadView()
        }
    }
    
    private func togglePlatformConnection(_ platformId: String) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            if connectedPlatforms.contains(platformId) {
                connectedPlatforms.remove(platformId)
            } else {
                connectedPlatforms.insert(platformId)
                // In a real app, this would trigger OAuth flow
                print("Connecting to \(platformId)")
            }
        }
    }
}

struct SocialPlatform {
    let id: String
    let name: String
    let icon: String
    let color: Color
    let description: String
}

struct SocialPlatformCard: View {
    let platform: SocialPlatform
    let isConnected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Platform icon with brand color
                ZStack {
                    Circle()
                        .fill(platform.color.opacity(0.2))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Circle()
                                .stroke(platform.color.opacity(0.3), lineWidth: 1)
                        )
                    
                    Image(systemName: platform.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(platform.color)
                }
                
                // Platform info
                VStack(alignment: .leading, spacing: 4) {
                    Text(platform.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text(platform.description)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Connection status
                if isConnected {
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 16, weight: .medium))
                        
                        Text("Connected")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.green)
                    }
                } else {
                    Text("Connect")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.2))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                )
                        )
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        isConnected ?
                        Color.white.opacity(0.2) :
                        Color.white.opacity(0.1)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                isConnected ?
                                Color.white.opacity(0.3) :
                                Color.white.opacity(0.2),
                                lineWidth: 1
                            )
                    )
            )
            .scaleEffect(isConnected ? 1.02 : 1.0)
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isConnected)
    }
}

#Preview {
    MusicianSocialSyncView()
} 