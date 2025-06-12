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
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 8) {
                            Text("DJ Setup - past events")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text("Add Event Details")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 20) {
                            // Event Name
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Event Name")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                
                                TextField("", text: $eventName)
                                    .font(.system(size: 16))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(8)
                            }
                            
                            // Venue / Location
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Venue / Location")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                
                                TextField("", text: $venue)
                                    .font(.system(size: 16))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(8)
                            }
                            
                            // Date
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Date")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                
                                HStack(spacing: 12) {
                                    // Start date
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("start")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.black.opacity(0.7))
                                        
                                        DatePicker("", selection: $startDate, displayedComponents: .date)
                                            .datePickerStyle(.compact)
                                            .labelsHidden()
                                            .background(Color.gray.opacity(0.3))
                                            .cornerRadius(8)
                                    }
                                    
                                    // End date
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("end")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.black.opacity(0.7))
                                        
                                        DatePicker("", selection: $endDate, displayedComponents: .date)
                                            .datePickerStyle(.compact)
                                            .labelsHidden()
                                            .background(Color.gray.opacity(0.3))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            
                            // Event Graphic
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Event Graphic")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                
                                PhotosPicker(selection: $selectedEventImage, matching: .images) {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(height: 120)
                                            .cornerRadius(8)
                                        
                                        if let eventImage = eventImage {
                                            Image(uiImage: eventImage)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(height: 120)
                                                .clipped()
                                                .cornerRadius(8)
                                        } else {
                                            Image(systemName: "plus")
                                                .font(.system(size: 32, weight: .medium))
                                                .foregroundColor(.black.opacity(0.6))
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
                                    .foregroundColor(.black)
                                
                                TextEditor(text: $eventDescription)
                                    .font(.system(size: 16))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(8)
                                    .frame(height: 80)
                            }
                            
                            // Music from Event
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Music from Event")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                
                                HStack(spacing: 12) {
                                    Button(action: {
                                        // Handle upload new music
                                        print("Upload new music")
                                    }) {
                                        Text("Upload")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.black)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .background(Color.gray.opacity(0.3))
                                            .cornerRadius(8)
                                    }
                                    
                                    Button(action: {
                                        showingMusicOptions = true
                                    }) {
                                        Text("Select from uploaded music")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.black)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .background(Color.gray.opacity(0.3))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                // Display selected music
                                if !musicFromEvent.isEmpty {
                                    VStack(alignment: .leading, spacing: 4) {
                                        ForEach(musicFromEvent, id: \.self) { track in
                                            HStack {
                                                Text("• \(track)")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.black.opacity(0.8))
                                                
                                                Spacer()
                                                
                                                Button(action: {
                                                    musicFromEvent.removeAll { $0 == track }
                                                }) {
                                                    Image(systemName: "xmark.circle.fill")
                                                        .foregroundColor(.black.opacity(0.6))
                                                }
                                            }
                                        }
                                    }
                                    .padding(.top, 8)
                                }
                            }
                            
                            // Media From Event
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Media From Event")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                
                                // Media grid (3x2 layout like wireframe)
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 8) {
                                    // First item is always the add button
                                    PhotosPicker(selection: $selectedMediaItems, maxSelectionCount: 6, matching: .images) {
                                        ZStack {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(height: 80)
                                                .cornerRadius(8)
                                            
                                            Image(systemName: "plus")
                                                .font(.system(size: 24, weight: .medium))
                                                .foregroundColor(.black.opacity(0.6))
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
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(height: 80)
                                                .cornerRadius(8)
                                            
                                            if index < mediaImages.count {
                                                Image(uiImage: mediaImages[index])
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(height: 80)
                                                    .clipped()
                                                    .cornerRadius(8)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.horizontal, 20)
                        
                        // Action buttons
                        HStack(spacing: 16) {
                            Button("Cancel") {
                                dismiss()
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white.opacity(0.2))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    )
                            )
                            
                            Button("Add Event") {
                                addEvent()
                            }
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
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
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.white.opacity(0.4), lineWidth: 1)
                                    )
                            )
                            .disabled(eventName.isEmpty || venue.isEmpty)
                            .opacity(eventName.isEmpty || venue.isEmpty ? 0.6 : 1.0)
                        }
                        .padding(.horizontal, 20)
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