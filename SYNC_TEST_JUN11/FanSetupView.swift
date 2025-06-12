//
//  FanSetupView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI

struct FanSetupView: View {
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    @State private var displayName = ""
    @State private var selectedGenres: Set<String> = []
    @State private var showOnWhosList = true
    @State private var shareEventsPublicly = true
    @State private var continueButtonPressed = false
    @Environment(\.dismiss) private var dismiss
    
    let availableGenres = [
        "Pop", "Rock", "Hip Hop", "Electronic", "Jazz", "Classical",
        "Country", "R&B", "Reggae", "Folk", "Blues", "Punk",
        "Metal", "Indie", "Alternative", "Latin", "World", "Funk"
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
                        
                        // Invisible spacer for balance
                        Color.clear
                            .frame(width: 44, height: 44)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Main content
                    VStack(spacing: 32) {
                        // Header
                        VStack(spacing: 12) {
                            Text("Fan Setup")
                                .font(.system(size: 28, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Tell us about your music preferences")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 20)
                        
                        // Form Fields
                        VStack(spacing: 24) {
                            // Display Name Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Display Name")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                TextField("Enter your display name", text: $displayName)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .placeholder(when: displayName.isEmpty) {
                                        Text("Enter your display name")
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
                            }
                            
                            // Favorite Genres Section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Favorite Genres")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                Text("Select up to 5 genres you love")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(.white.opacity(0.7))
                                
                                // Genre Tags
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 12) {
                                    ForEach(availableGenres, id: \.self) { genre in
                                        GenreTag(
                                            genre: genre,
                                            isSelected: selectedGenres.contains(genre),
                                            isDisabled: !selectedGenres.contains(genre) && selectedGenres.count >= 5
                                        ) {
                                            toggleGenre(genre)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                        
                        // Privacy Settings
                        VStack(spacing: 20) {
                            Text("Privacy Settings")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 32)
                            
                            VStack(spacing: 16) {
                                // Who's Going Toggle
                                ToggleRow(
                                    title: "Be shown on 'Who's going' list",
                                    subtitle: "Other users can see you're attending events",
                                    isOn: $showOnWhosList
                                )
                                
                                // Share Events Toggle
                                ToggleRow(
                                    title: "Share my saved events publicly",
                                    subtitle: "Let friends see events you've saved",
                                    isOn: $shareEventsPublicly
                                )
                            }
                            .padding(.horizontal, 32)
                        }
                        
                        // Continue Button
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                continueButtonPressed.toggle()
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                continueButtonPressed = false
                            }
                            
                            // Handle fan setup completion
                            print("Fan setup completed - Display Name: \(displayName), Genres: \(selectedGenres), Who's List: \(showOnWhosList), Share Events: \(shareEventsPublicly)")
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
                        .disabled(displayName.isEmpty || selectedGenres.isEmpty)
                        .opacity(displayName.isEmpty || selectedGenres.isEmpty ? 0.6 : 1.0)
                        .padding(.horizontal, 32)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func toggleGenre(_ genre: String) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            if selectedGenres.contains(genre) {
                selectedGenres.remove(genre)
            } else if selectedGenres.count < 5 {
                selectedGenres.insert(genre)
            }
        }
    }
}

struct GenreTag: View {
    let genre: String
    let isSelected: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(genre)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? .white : (isDisabled ? .white.opacity(0.4) : .white.opacity(0.8)))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            isSelected ?
                            Color.white.opacity(0.3) :
                            Color.white.opacity(isDisabled ? 0.1 : 0.15)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    isSelected ?
                                    Color.white.opacity(0.5) :
                                    Color.white.opacity(isDisabled ? 0.2 : 0.3),
                                    lineWidth: 1
                                )
                        )
                )
                .scaleEffect(isSelected ? 1.05 : 1.0)
        }
        .disabled(isDisabled)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}

struct ToggleRow: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                    
                    Text(subtitle)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
                
                Toggle("", isOn: $isOn)
                    .toggleStyle(CustomToggleStyle())
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
        }
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(configuration.isOn ? Color.white.opacity(0.3) : Color.white.opacity(0.15))
                    .frame(width: 50, height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 24, height: 24)
                    .offset(x: configuration.isOn ? 10 : -10)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isOn)
            }
            .onTapGesture {
                configuration.isOn.toggle()
            }
        }
    }
}

#Preview {
    FanSetupView()
} 