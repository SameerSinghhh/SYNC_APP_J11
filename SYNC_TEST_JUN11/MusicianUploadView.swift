//
//  MusicianUploadView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI
import PhotosUI

struct MusicianUploadView: View {
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    @State private var continueButtonPressed = false
    @State private var skipButtonPressed = false
    @State private var selectedTab = 0
    @Environment(\.dismiss) private var dismiss
    
    // Music upload states
    @State private var uploadedTracks: [MusicTrack] = []
    @State private var showingMusicPicker = false
    
    // Past events states
    @State private var pastEvents: [PastEvent] = []
    @State private var showingAddEvent = false
    
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
                        
                        // Progress indicator (step 3 of 5)
                        HStack(spacing: 4) {
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 8, height: 8)
                            
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 8, height: 8)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 8, height: 8)
                            
                            ForEach(0..<2, id: \.self) { _ in
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
                            Text("Showcase Your Work")
                                .font(.system(size: 28, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Upload your music and showcase your past events")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                        }
                        .padding(.top, 20)
                        
                        // Tab Selector
                        HStack(spacing: 0) {
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    selectedTab = 0
                                }
                            }) {
                                VStack(spacing: 8) {
                                    Image(systemName: "music.note")
                                        .font(.system(size: 20, weight: .medium))
                                    
                                    Text("Music")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .foregroundColor(selectedTab == 0 ? .white : .white.opacity(0.6))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(selectedTab == 0 ? Color.white.opacity(0.2) : Color.clear)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(selectedTab == 0 ? Color.white.opacity(0.3) : Color.clear, lineWidth: 1)
                                        )
                                )
                            }
                            
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    selectedTab = 1
                                }
                            }) {
                                VStack(spacing: 8) {
                                    Image(systemName: "calendar")
                                        .font(.system(size: 20, weight: .medium))
                                    
                                    Text("Past Events")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .foregroundColor(selectedTab == 1 ? .white : .white.opacity(0.6))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(selectedTab == 1 ? Color.white.opacity(0.2) : Color.clear)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(selectedTab == 1 ? Color.white.opacity(0.3) : Color.clear, lineWidth: 1)
                                        )
                                )
                            }
                        }
                        .padding(.horizontal, 32)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        )
                        .padding(.horizontal, 32)
                        
                        // Content based on selected tab
                        if selectedTab == 0 {
                            MusicUploadSection(
                                uploadedTracks: $uploadedTracks,
                                showingMusicPicker: $showingMusicPicker
                            )
                        } else {
                            PastEventsSection(
                                pastEvents: $pastEvents,
                                showingAddEvent: $showingAddEvent
                            )
                        }
                        
                        // Action buttons
                        VStack(spacing: 16) {
                            // Continue Button
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    continueButtonPressed.toggle()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    continueButtonPressed = false
                                }
                                
                                // Handle continue to next step
                                print("Music and events upload completed - Tracks: \(uploadedTracks.count), Events: \(pastEvents.count)")
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
                                print("Music and events upload skipped")
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
        .sheet(isPresented: $showingAddEvent) {
            AddPastEventView(pastEvents: $pastEvents)
        }
    }
}

// MARK: - Music Upload Section
struct MusicUploadSection: View {
    @Binding var uploadedTracks: [MusicTrack]
    @Binding var showingMusicPicker: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            // Upload button
            Button(action: {
                showingMusicPicker = true
            }) {
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
                            )
                        
                        Image(systemName: "plus")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 8) {
                        Text("Upload Music")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text("Add .mp3 or .wav files")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                )
            }
            .padding(.horizontal, 32)
            
            // Uploaded tracks list
            if !uploadedTracks.isEmpty {
                VStack(spacing: 16) {
                    HStack {
                        Text("Uploaded Tracks (\(uploadedTracks.count))")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 32)
                    
                    ForEach(uploadedTracks, id: \.id) { track in
                        MusicTrackCard(track: track) {
                            // Remove track
                            uploadedTracks.removeAll { $0.id == track.id }
                        }
                    }
                    .padding(.horizontal, 32)
                }
            }
        }
    }
}

// MARK: - Past Events Section
struct PastEventsSection: View {
    @Binding var pastEvents: [PastEvent]
    @Binding var showingAddEvent: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            // Add event button
            Button(action: {
                showingAddEvent = true
            }) {
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
                            )
                        
                        Image(systemName: "plus")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 8) {
                        Text("Add Past Event")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text("Showcase your experience")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                )
            }
            .padding(.horizontal, 32)
            
            // Past events list
            if !pastEvents.isEmpty {
                VStack(spacing: 16) {
                    HStack {
                        Text("Past Events (\(pastEvents.count))")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 32)
                    
                    ForEach(pastEvents, id: \.id) { event in
                        PastEventCard(event: event) {
                            // Remove event
                            pastEvents.removeAll { $0.id == event.id }
                        }
                    }
                    .padding(.horizontal, 32)
                }
            }
        }
    }
}

// MARK: - Music Track Card
struct MusicTrackCard: View {
    let track: MusicTrack
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Music icon
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                
                Image(systemName: "music.note")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
            
            // Track info
            VStack(alignment: .leading, spacing: 4) {
                Text(track.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(track.fileType.uppercased())
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            // Remove button
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

// MARK: - Past Event Card
struct PastEventCard: View {
    let event: PastEvent
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Event image or placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                
                if let image = event.eventImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Image(systemName: "calendar")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            
            // Event info
            VStack(alignment: .leading, spacing: 4) {
                Text(event.eventName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(event.venue)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)
                
                Text(event.startDate, style: .date)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            // Remove button
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

// MARK: - Data Models
struct MusicTrack: Identifiable {
    let id = UUID()
    let name: String
    let fileType: String
    let url: URL?
}

struct PastEvent: Identifiable {
    let id = UUID()
    let eventName: String
    let venue: String
    let startDate: Date
    let endDate: Date
    let eventImage: UIImage?
    let description: String
    let musicFromEvent: [String] // Track names or URLs
    let mediaFromEvent: [UIImage] // Photos from event
}

#Preview {
    MusicianUploadView()
} 