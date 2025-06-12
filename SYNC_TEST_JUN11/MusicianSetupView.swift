//
//  MusicianSetupView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI

struct MusicianSetupView: View {
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    @State private var artistName = ""
    @State private var selectedArtistType: ArtistType = .dj
    @State private var selectedGenres: Set<String> = []
    @State private var continueButtonPressed = false
    @State private var navigateToSocialSync = false
    @Environment(\.dismiss) private var dismiss
    
    let availableGenres = [
        "Pop", "Rock", "Hip Hop", "Electronic", "Jazz", "Classical",
        "Country", "R&B", "Reggae", "Folk", "Blues", "Punk",
        "Metal", "Indie", "Alternative", "Latin", "World", "Funk",
        "House", "Techno", "Dubstep", "Trap", "Ambient", "Gospel"
    ]
    
    enum ArtistType: String, CaseIterable {
        case dj = "DJ"
        case singer = "Singer"
        case guitarist = "Guitarist"
        case bassist = "Bassist"
        case drummer = "Drummer"
        case pianist = "Pianist"
        case producer = "Producer"
        case rapper = "Rapper"
        case violinist = "Violinist"
        case saxophonist = "Saxophonist"
        case band = "Band"
        case other = "Other"
        
        var icon: String {
            switch self {
            case .dj: return "hifispeaker.fill"
            case .singer: return "mic.fill"
            case .guitarist: return "guitars.fill"
            case .bassist: return "guitars.fill"
            case .drummer: return "music.note"
            case .pianist: return "pianokeys"
            case .producer: return "waveform"
            case .rapper: return "mic.circle.fill"
            case .violinist: return "music.note"
            case .saxophonist: return "music.note"
            case .band: return "person.3.fill"
            case .other: return "music.quarternote.3"
            }
        }
        
        var description: String {
            switch self {
            case .dj: return "Mix and play music for crowds"
            case .singer: return "Vocal performances and concerts"
            case .guitarist: return "Guitar performances and sessions"
            case .bassist: return "Bass guitar and rhythm section"
            case .drummer: return "Percussion and rhythm"
            case .pianist: return "Piano and keyboard performances"
            case .producer: return "Music production and beats"
            case .rapper: return "Hip-hop and rap performances"
            case .violinist: return "Classical and contemporary violin"
            case .saxophonist: return "Jazz and contemporary saxophone"
            case .band: return "Group musical performances"
            case .other: return "Other musical talents"
            }
        }
    }
    
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
                        
                        // Progress indicator
                        HStack(spacing: 4) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 8, height: 8)
                            
                            ForEach(0..<4, id: \.self) { _ in
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
                        VStack(spacing: 12) {
                            Text("Artist Setup")
                                .font(.system(size: 28, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Let's set up your artist profile")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 20)
                        
                        // Artist Name Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Artist Name *")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                            
                            TextField("Enter your artist name", text: $artistName)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .placeholder(when: artistName.isEmpty) {
                                    Text("Enter your artist name")
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
                        .padding(.horizontal, 32)
                        
                        // Artist Type Selection
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Type of Artist *")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.horizontal, 32)
                            
                            Text("What best describes your musical role?")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.white.opacity(0.7))
                                .padding(.horizontal, 32)
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 12) {
                                ForEach(ArtistType.allCases, id: \.self) { artistType in
                                    ArtistTypeCard(
                                        artistType: artistType,
                                        isSelected: selectedArtistType == artistType
                                    ) {
                                        selectedArtistType = artistType
                                    }
                                }
                            }
                            .padding(.horizontal, 32)
                        }
                        
                        // Genre Selection
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Genres You Play")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.horizontal, 32)
                            
                            Text("Select all genres that apply to your music")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.white.opacity(0.7))
                                .padding(.horizontal, 32)
                            
                            // Genre Tags
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 12) {
                                ForEach(availableGenres, id: \.self) { genre in
                                    MusicianGenreTag(
                                        genre: genre,
                                        isSelected: selectedGenres.contains(genre)
                                    ) {
                                        toggleGenre(genre)
                                    }
                                }
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
                                navigateToSocialSync = true
                            }
                            
                            // Handle continue to next step
                            print("Artist setup step 1 completed - Name: \(artistName), Type: \(selectedArtistType.rawValue), Genres: \(selectedGenres)")
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
                        .disabled(artistName.isEmpty)
                        .opacity(artistName.isEmpty ? 0.6 : 1.0)
                        .padding(.horizontal, 32)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToSocialSync) {
            MusicianSocialSyncView()
        }
    }
    
    private func toggleGenre(_ genre: String) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            if selectedGenres.contains(genre) {
                selectedGenres.remove(genre)
            } else {
                selectedGenres.insert(genre)
            }
        }
    }
}

struct ArtistTypeCard: View {
    let artistType: MusicianSetupView.ArtistType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                // Icon
                Image(systemName: artistType.icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.8))
                    .frame(width: 24, height: 24)
                
                // Title
                Text(artistType.rawValue)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.9))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        isSelected ?
                        Color.white.opacity(0.25) :
                        Color.white.opacity(0.15)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                isSelected ?
                                Color.white.opacity(0.4) :
                                Color.white.opacity(0.2),
                                lineWidth: 1
                            )
                    )
            )
            .scaleEffect(isSelected ? 1.02 : 1.0)
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}

struct MusicianGenreTag: View {
    let genre: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(genre)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(isSelected ? .white : .white.opacity(0.8))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            isSelected ?
                            Color.white.opacity(0.3) :
                            Color.white.opacity(0.15)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    isSelected ?
                                    Color.white.opacity(0.5) :
                                    Color.white.opacity(0.3),
                                    lineWidth: 1
                                )
                        )
                )
                .scaleEffect(isSelected ? 1.05 : 1.0)
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}

#Preview {
    MusicianSetupView()
} 