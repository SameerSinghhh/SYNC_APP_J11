//
//  FindFriendsView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI
import Contacts

struct FindFriendsView: View {
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    @State private var contactsPermissionGranted = false
    @State private var showingPermissionAlert = false
    @State private var friendsOnPlatform: [PlatformFriend] = []
    @State private var followedFriends: Set<String> = []
    @State private var continueButtonPressed = false
    @State private var syncButtonPressed = false
    @State private var isLoadingContacts = false
    @Environment(\.dismiss) private var dismiss
    
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
            ForEach(0..<10, id: \.self) { index in
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
                    
                    // Skip button
                    Button(action: {
                        // Handle skip
                        print("Skip contacts sync")
                    }) {
                        Text("Skip")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                ScrollView {
                    VStack(spacing: 32) {
                        // Header
                        VStack(spacing: 16) {
                            Text("Find Friends")
                                .font(.system(size: 28, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Connect with friends who are already on SYNC")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                        }
                        .padding(.top, 20)
                        
                        if !contactsPermissionGranted && friendsOnPlatform.isEmpty {
                            // Contacts permission section
                            VStack(spacing: 24) {
                                // Icon
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    Color.white.opacity(0.25),
                                                    Color.white.opacity(0.15)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 100, height: 100)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                                        )
                                    
                                    Image(systemName: "person.2.fill")
                                        .font(.system(size: 40, weight: .medium))
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                
                                VStack(spacing: 12) {
                                    Text("Sync Your Contacts")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(.white)
                                    
                                    Text("We'll help you find friends who are already using SYNC. Your contacts are kept private and secure.")
                                        .font(.system(size: 14, weight: .light))
                                        .foregroundColor(.white.opacity(0.7))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 32)
                                }
                                
                                // Sync Contacts Button
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        syncButtonPressed.toggle()
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        syncButtonPressed = false
                                    }
                                    
                                    requestContactsPermission()
                                }) {
                                    HStack(spacing: 12) {
                                        if isLoadingContacts {
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                                .scaleEffect(0.8)
                                        } else {
                                            Image(systemName: "arrow.clockwise")
                                                .font(.system(size: 16, weight: .medium))
                                        }
                                        
                                        Text(isLoadingContacts ? "Syncing..." : "Sync Contacts")
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
                                    .scaleEffect(syncButtonPressed ? 0.95 : 1.0)
                                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                }
                                .disabled(isLoadingContacts)
                                .padding(.horizontal, 32)
                            }
                        } else {
                            // Friends list section
                            VStack(spacing: 20) {
                                if friendsOnPlatform.isEmpty {
                                    // No friends found
                                    VStack(spacing: 16) {
                                        Image(systemName: "person.crop.circle.badge.questionmark")
                                            .font(.system(size: 50, weight: .light))
                                            .foregroundColor(.white.opacity(0.6))
                                        
                                        Text("No Friends Found")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Text("None of your contacts are on SYNC yet. Invite them to join!")
                                            .font(.system(size: 14, weight: .light))
                                            .foregroundColor(.white.opacity(0.7))
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 32)
                                    }
                                    .padding(.top, 40)
                                } else {
                                    // Friends list header
                                    HStack {
                                        Text("Friends on SYNC")
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Text("\(friendsOnPlatform.count) found")
                                            .font(.system(size: 14, weight: .light))
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                    .padding(.horizontal, 32)
                                    
                                    // Friends list
                                    LazyVStack(spacing: 12) {
                                        ForEach(friendsOnPlatform) { friend in
                                            FriendCard(
                                                friend: friend,
                                                isFollowed: followedFriends.contains(friend.id)
                                            ) {
                                                toggleFollow(friend: friend)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 32)
                                }
                            }
                        }
                        
                        // Continue Button
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                continueButtonPressed.toggle()
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                continueButtonPressed = false
                            }
                            
                            // Handle continue to next step
                            print("Continue to next step")
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
                        .padding(.horizontal, 32)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .alert("Contacts Permission", isPresented: $showingPermissionAlert) {
            Button("Settings") {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please enable contacts access in Settings to find your friends on SYNC.")
        }
        .onAppear {
            loadMockFriendsData()
        }
    }
    
    private func requestContactsPermission() {
        isLoadingContacts = true
        
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            DispatchQueue.main.async {
                isLoadingContacts = false
                
                if granted {
                    contactsPermissionGranted = true
                    loadFriendsFromContacts()
                } else {
                    showingPermissionAlert = true
                }
            }
        }
    }
    
    private func loadFriendsFromContacts() {
        // In a real app, this would sync contacts with your backend
        // For now, we'll show mock data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            loadMockFriendsData()
        }
    }
    
    private func loadMockFriendsData() {
        friendsOnPlatform = [
            PlatformFriend(id: "1", name: "Alex Johnson", username: "@alexj", accountType: "DJ / Musician", profileImage: nil, mutualFriends: 3),
            PlatformFriend(id: "2", name: "Sarah Chen", username: "@sarahc", accountType: "Fan", profileImage: nil, mutualFriends: 7),
            PlatformFriend(id: "3", name: "Mike Rodriguez", username: "@mikerodz", accountType: "Venue", profileImage: nil, mutualFriends: 2),
            PlatformFriend(id: "4", name: "Emma Wilson", username: "@emmaw", accountType: "DJ / Musician", profileImage: nil, mutualFriends: 5),
            PlatformFriend(id: "5", name: "David Park", username: "@dpark", accountType: "Fan", profileImage: nil, mutualFriends: 1)
        ]
    }
    
    private func toggleFollow(friend: PlatformFriend) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            if followedFriends.contains(friend.id) {
                followedFriends.remove(friend.id)
            } else {
                followedFriends.insert(friend.id)
            }
        }
    }
}

struct PlatformFriend: Identifiable {
    let id: String
    let name: String
    let username: String
    let accountType: String
    let profileImage: UIImage?
    let mutualFriends: Int
}

struct FriendCard: View {
    let friend: PlatformFriend
    let isFollowed: Bool
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Profile Image
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.25),
                                Color.white.opacity(0.15)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                
                if let profileImage = friend.profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    Text(String(friend.name.prefix(1)))
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            
            // Friend Info
            VStack(alignment: .leading, spacing: 4) {
                Text(friend.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(friend.username)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
                
                HStack(spacing: 4) {
                    Text(friend.accountType)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(.white.opacity(0.6))
                    
                    Text("•")
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(.white.opacity(0.4))
                    
                    Text("\(friend.mutualFriends) mutual")
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            
            Spacer()
            
            // Follow Button
            Button(action: action) {
                Text(isFollowed ? "Following" : "Follow")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isFollowed ? .white.opacity(0.8) : .white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                isFollowed ?
                                Color.white.opacity(0.15) :
                                Color.white.opacity(0.25)
                            )
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
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

#Preview {
    FindFriendsView()
} 