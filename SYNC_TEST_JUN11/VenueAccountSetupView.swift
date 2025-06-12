//
//  VenueAccountSetupView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/12/25.
//

import SwiftUI
import MapKit

struct VenueAccountSetupView: View {
    @State private var venues: [Venue] = []
    @State private var newVenue = Venue(name: "", type: .bar, address: "", description: "", coordinate: nil)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var isEditing = false
    @State private var showMapPin = false
    
    var body: some View {
        ZStack {
            // Cool-tone animated background
            VenueBackground()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Spacer()
                        HStack(spacing: 8) {
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
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    VStack(spacing: 32) {
                        // Title
                        VStack(spacing: 12) {
                            Text("Venue Account Setup")
                                .font(.system(size: 28, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                            Text("Add and manage your venues")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.top, 10)
                        
                        // Venue Form
                        VenueForm(newVenue: $newVenue, region: $region, showMapPin: $showMapPin, onAdd: addVenue)
                        
                        // List of added venues
                        if !venues.isEmpty {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Your Venues")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                    .padding(.horizontal, 32)
                                ForEach(venues) { venue in
                                    VenueCard(venue: venue)
                                        .padding(.horizontal, 32)
                                }
                            }
                        }
                        
                        // Map
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Venue Locations")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.horizontal, 32)
                            Map(coordinateRegion: $region,
                                annotationItems: venuesWithPins) { venue in
                                MapMarker(coordinate: venue.coordinate ?? CLLocationCoordinate2D(),
                                         tint: .white)
                            }
                            .frame(height: 250)
                            .cornerRadius(20)
                            .padding(.horizontal, 32)
                            .shadow(radius: 10)
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }
    
    // Helper to only show venues with coordinates
    var venuesWithPins: [Venue] {
        venues.filter { $0.coordinate != nil }
    }
    
    // Add venue logic
    func addVenue() {
        guard !newVenue.name.isEmpty, !newVenue.address.isEmpty, let coord = newVenue.coordinate else { return }
        venues.append(newVenue)
        newVenue = Venue(name: "", type: .bar, address: "", description: "", coordinate: nil)
        // Optionally, recenter map
        region.center = coord
        showMapPin = false
    }
}

// MARK: - Venue Form
struct VenueForm: View {
    @Binding var newVenue: Venue
    @Binding var region: MKCoordinateRegion
    @Binding var showMapPin: Bool
    var onAdd: () -> Void
    
    let venueTypes: [VenueType] = VenueType.allCases
    
    var body: some View {
        VStack(spacing: 20) {
            // Name
            VStack(alignment: .leading, spacing: 8) {
                Text("Venue Name")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                TextField("Enter venue name", text: $newVenue.name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
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
            // Type
            VStack(alignment: .leading, spacing: 8) {
                Text("Venue Type")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                Picker("Venue Type", selection: $newVenue.type) {
                    ForEach(venueTypes, id: \.self) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.1))
                )
            }
            // Address
            VStack(alignment: .leading, spacing: 8) {
                Text("Address")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                HStack {
                    TextField("Enter address", text: $newVenue.address, onCommit: geocodeAddress)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
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
                    Button(action: geocodeAddress) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.8))
                            .padding(10)
                            .background(Circle().fill(Color.white.opacity(0.15)))
                    }
                }
            }
            // Description
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                TextEditor(text: $newVenue.description)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(height: 60)
                    .padding(.horizontal, 8)
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
            // Add Button
            Button(action: onAdd) {
                HStack(spacing: 12) {
                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .medium))
                    Text("Add Venue")
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
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
        )
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    // Geocode address to get coordinates
    func geocodeAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(newVenue.address) { placemarks, error in
            if let location = placemarks?.first?.location {
                newVenue.coordinate = location.coordinate
                region.center = location.coordinate
                showMapPin = true
            }
        }
    }
}

// MARK: - Venue Card
struct VenueCard: View {
    let venue: Venue
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(venue.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Text(venue.type.rawValue.capitalized)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
            }
            Text(venue.address)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
            if !venue.description.isEmpty {
                Text(venue.description)
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.18), lineWidth: 1)
                )
        )
    }
}

// MARK: - Venue Model
struct Venue: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var type: VenueType
    var address: String
    var description: String
    var coordinate: CLLocationCoordinate2D?

    static func == (lhs: Venue, rhs: Venue) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.type == rhs.type &&
        lhs.address == rhs.address &&
        lhs.description == rhs.description &&
        lhs.coordinate?.latitude == rhs.coordinate?.latitude &&
        lhs.coordinate?.longitude == rhs.coordinate?.longitude
    }
}

enum VenueType: String, CaseIterable {
    case bar, club, frat, restaurant, lounge, hall, other
}

// MARK: - Animated Background
struct VenueBackground: View {
    @State private var animate1 = false
    @State private var animate2 = false
    @State private var animate3 = false
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.4, blue: 0.9),
                    Color(red: 0.1, green: 0.6, blue: 0.8),
                    Color(red: 0.3, green: 0.5, blue: 0.8)
                ],
                startPoint: animate1 ? .topLeading : .bottomTrailing,
                endPoint: animate1 ? .bottomTrailing : .topLeading
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                    animate1.toggle()
                }
            }
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.7, blue: 0.6).opacity(0.7),
                    Color(red: 0.4, green: 0.3, blue: 0.9).opacity(0.7),
                    Color(red: 0.2, green: 0.8, blue: 0.7).opacity(0.7)
                ],
                startPoint: animate2 ? .topTrailing : .bottomLeading,
                endPoint: animate2 ? .bottomLeading : .topTrailing
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                    animate2.toggle()
                }
            }
            RadialGradient(
                colors: [
                    Color(red: 0.3, green: 0.4, blue: 0.8).opacity(0.4),
                    Color.clear
                ],
                center: animate3 ? .topLeading : .bottomTrailing,
                startRadius: 50,
                endRadius: 400
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                    animate3.toggle()
                }
            }
        }
    }
}

#Preview {
    VenueAccountSetupView()
} 