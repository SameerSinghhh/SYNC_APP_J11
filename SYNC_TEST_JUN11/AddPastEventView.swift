//
//  AddPastEventView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI
import PhotosUI

struct AddPastEventView: View {
    @Binding var pastEvents: [PastEvent]
    @Environment(\.dismiss) private var dismiss
    
    @State private var eventName = ""
    @State private var venue = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var eventDescription = ""
    @State private var selectedEventImage: PhotosPickerItem?
    @State private var eventImage: UIImage?
    @State private var selectedMediaItems: [PhotosPickerItem] = []
    @State private var mediaImages: [UIImage] = []
    @State private var musicFromEvent: [String] = []
    @State private var newMusicTrack = ""
    @State private var showingMusicOptions = false
    
    // Animation states for gradient background
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    
    var body: some View {
        NavigationView {
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
                    VStack(spacing: 24) {
                        // Header with SYNC logo and back button
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
                            
                            // SYNC Logo
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
                            
                            // Placeholder for symmetry
                            Color.clear
                                .frame(width: 44, height: 44)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        // Title section
                        VStack(spacing: 16) {
                            Text("Add Past Event")
                                .font(.system(size: 28, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Showcase your musical experience")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 10)
                        
                        VStack(spacing: 20) {
                            // Event Name
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Event Name")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                TextField("Enter event name", text: $eventName)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .placeholder(when: eventName.isEmpty) {
                                        Text("Enter event name")
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
                            
                            // Venue / Location
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Venue / Location")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                TextField("Enter venue or location", text: $venue)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .placeholder(when: venue.isEmpty) {
                                        Text("Enter venue or location")
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
                            
                            // Date
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Date")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                HStack(spacing: 12) {
                                    // Start date
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Start Date")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.white.opacity(0.8))
                                        
                                        DatePicker("", selection: $startDate, displayedComponents: .date)
                                            .datePickerStyle(.compact)
                                            .labelsHidden()
                                            .colorScheme(.dark)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color.white.opacity(0.2))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                                    )
                                            )
                                    }
                                    
                                    // End date
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("End Date")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.white.opacity(0.8))
                                        
                                        DatePicker("", selection: $endDate, displayedComponents: .date)
                                            .datePickerStyle(.compact)
                                            .labelsHidden()
                                            .colorScheme(.dark)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color.white.opacity(0.2))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                                    )
                                            )
                                    }
                                }
                            }
                            
                            // Event Graphic
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Event Graphic")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                PhotosPicker(selection: $selectedEventImage, matching: .images) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.white.opacity(0.2))
                                            .frame(height: 120)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                            )
                                        
                                        if let eventImage = eventImage {
                                            Image(uiImage: eventImage)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(height: 120)
                                                .clipped()
                                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                        } else {
                                            VStack(spacing: 8) {
                                                Image(systemName: "plus")
                                                    .font(.system(size: 32, weight: .medium))
                                                    .foregroundColor(.white.opacity(0.8))
                                                
                                                Text("Add Event Poster")
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.white.opacity(0.7))
                                            }
                                        }
                                    }
                                }
                                .onChange(of: selectedEventImage) { _, newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                                           let image = UIImage(data: data) {
                                            eventImage = image
                                        }
                                    }
                                }
                            }
                            
                            // Description
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                ZStack(alignment: .topLeading) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.2))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                        )
                                        .frame(height: 80)
                                    
                                    if eventDescription.isEmpty {
                                        Text("Describe the event...")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.white.opacity(0.6))
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 12)
                                    }
                                    
                                    TextEditor(text: $eventDescription)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.white)
                                        .background(Color.clear)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .frame(height: 80)
                                        .scrollContentBackground(.hidden)
                                }
                            }
                            
                            // Music from Event
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Music from Event")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                HStack(spacing: 12) {
                                    Button(action: {
                                        // Handle upload new music
                                        print("Upload new music")
                                    }) {
                                        Text("Upload")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color.white.opacity(0.2))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                                    )
                                            )
                                    }
                                    
                                    Button(action: {
                                        showingMusicOptions = true
                                    }) {
                                        Text("Select from library")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color.white.opacity(0.2))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                                    )
                                            )
                                    }
                                }
                                
                                // Display selected music
                                if !musicFromEvent.isEmpty {
                                    VStack(alignment: .leading, spacing: 8) {
                                        ForEach(musicFromEvent, id: \.self) { track in
                                            HStack {
                                                Image(systemName: "music.note")
                                                    .font(.system(size: 12, weight: .medium))
                                                    .foregroundColor(.white.opacity(0.7))
                                                
                                                Text(track)
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.white.opacity(0.9))
                                                
                                                Spacer()
                                                
                                                Button(action: {
                                                    musicFromEvent.removeAll { $0 == track }
                                                }) {
                                                    Image(systemName: "xmark.circle.fill")
                                                        .font(.system(size: 16, weight: .medium))
                                                        .foregroundColor(.white.opacity(0.6))
                                                }
                                            }
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.white.opacity(0.1))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 8)
                                                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                                    )
                                            )
                                        }
                                    }
                                    .padding(.top, 8)
                                }
                            }
                            
                            // Media From Event
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Media From Event")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                // Media grid (3x2 layout like wireframe)
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 8) {
                                    // First item is always the add button
                                    PhotosPicker(selection: $selectedMediaItems, maxSelectionCount: 6, matching: .images) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white.opacity(0.2))
                                                .frame(height: 80)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                                )
                                            
                                            VStack(spacing: 4) {
                                                Image(systemName: "plus")
                                                    .font(.system(size: 20, weight: .medium))
                                                    .foregroundColor(.white.opacity(0.8))
                                                
                                                Text("Add Photos")
                                                    .font(.system(size: 10, weight: .medium))
                                                    .foregroundColor(.white.opacity(0.7))
                                            }
                                        }
                                    }
                                    .onChange(of: selectedMediaItems) { _, newItems in
                                        Task {
                                            var newImages: [UIImage] = []
                                            for item in newItems {
                                                if let data = try? await item.loadTransferable(type: Data.self),
                                                   let image = UIImage(data: data) {
                                                    newImages.append(image)
                                                }
                                            }
                                            mediaImages = newImages
                                        }
                                    }
                                    
                                    // Display selected media (up to 5 more slots)
                                    ForEach(0..<5, id: \.self) { index in
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white.opacity(0.2))
                                                .frame(height: 80)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                                )
                                            
                                            if index < mediaImages.count {
                                                Image(uiImage: mediaImages[index])
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(height: 80)
                                                    .clipped()
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                        
                        // Action buttons
                        VStack(spacing: 16) {
                            Button("Add Event") {
                                addEvent()
                            }
                            .font(.system(size: 18, weight: .semibold))
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
                            .disabled(eventName.isEmpty || venue.isEmpty)
                            .opacity(eventName.isEmpty || venue.isEmpty ? 0.6 : 1.0)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                            
                            Button("Cancel") {
                                dismiss()
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .underline()
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .actionSheet(isPresented: $showingMusicOptions) {
            ActionSheet(
                title: Text("Add Music Track"),
                buttons: [
                    .default(Text("Sample Track 1")) {
                        musicFromEvent.append("Sample Track 1")
                    },
                    .default(Text("Sample Track 2")) {
                        musicFromEvent.append("Sample Track 2")
                    },
                    .default(Text("Sample Track 3")) {
                        musicFromEvent.append("Sample Track 3")
                    },
                    .cancel()
                ]
            )
        }
    }
    
    private func addEvent() {
        let newEvent = PastEvent(
            eventName: eventName,
            venue: venue,
            startDate: startDate,
            endDate: endDate,
            eventImage: eventImage,
            description: eventDescription,
            musicFromEvent: musicFromEvent,
            mediaFromEvent: mediaImages
        )
        
        pastEvents.append(newEvent)
        dismiss()
    }
}

#Preview {
    AddPastEventView(pastEvents: .constant([]))
} 