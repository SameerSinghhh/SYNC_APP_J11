//
//  AccountSetupView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI

struct AccountSetupView: View {
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    @State private var username = ""
    @State private var location = ""
    @State private var selectedAccountType: AccountType = .fan
    @State private var showImagePicker = false
    @State private var continueButtonPressed = false
    @State private var profileImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    enum AccountType: String, CaseIterable {
        case djMusician = "DJ / Musician"
        case venue = "Venue"
        case fan = "Fan"
        
        var icon: String {
            switch self {
            case .djMusician: return "music.note"
            case .venue: return "building.2"
            case .fan: return "heart.fill"
            }
        }
        
        var description: String {
            switch self {
            case .djMusician: return "Share your music and connect with fans"
            case .venue: return "Host events and discover talent"
            case .fan: return "Discover music and follow your favorites"
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
                            Text("Account Setup")
                                .font(.system(size: 28, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Let's create your profile")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.top, 20)
                        
                        // Profile Photo Section
                        VStack(spacing: 16) {
                            Button(action: {
                                showImagePicker = true
                            }) {
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
                                        .frame(width: 120, height: 120)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                                        )
                                    
                                    if let profileImage = profileImage {
                                        Image(uiImage: profileImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 120, height: 120)
                                            .clipShape(Circle())
                                    } else {
                                        VStack(spacing: 8) {
                                            Image(systemName: "camera.fill")
                                                .font(.system(size: 24, weight: .medium))
                                                .foregroundColor(.white.opacity(0.8))
                                            
                                            Text("Add Photo")
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(.white.opacity(0.7))
                                        }
                                    }
                                    
                                    // Edit icon overlay
                                    Circle()
                                        .fill(Color.white.opacity(0.9))
                                        .frame(width: 32, height: 32)
                                        .overlay(
                                            Image(systemName: "pencil")
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundColor(.black)
                                        )
                                        .offset(x: 35, y: 35)
                                }
                            }
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                        
                        // Form Fields
                        VStack(spacing: 20) {
                            // Username Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Username")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                TextField("Enter your username", text: $username)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .placeholder(when: username.isEmpty) {
                                        Text("Enter your username")
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
                            
                            // Location Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Location")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                TextField("Enter your location", text: $location)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .placeholder(when: location.isEmpty) {
                                        Text("Enter your location")
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
                        }
                        .padding(.horizontal, 32)
                        
                        // Account Type Selection
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Account Type")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.horizontal, 32)
                            
                            VStack(spacing: 12) {
                                ForEach(AccountType.allCases, id: \.self) { accountType in
                                    AccountTypeCard(
                                        accountType: accountType,
                                        isSelected: selectedAccountType == accountType
                                    ) {
                                        selectedAccountType = accountType
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
                            }
                            
                            // Handle account setup completion
                            print("Account setup completed - Username: \(username), Location: \(location), Type: \(selectedAccountType.rawValue)")
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
                        .disabled(username.isEmpty || location.isEmpty)
                        .opacity(username.isEmpty || location.isEmpty ? 0.6 : 1.0)
                        .padding(.horizontal, 32)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $profileImage)
        }
    }
}

struct AccountTypeCard: View {
    let accountType: AccountSetupView.AccountType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Icon
                Image(systemName: accountType.icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.8))
                    .frame(width: 24, height: 24)
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(accountType.rawValue)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isSelected ? .white : .white.opacity(0.9))
                    
                    Text(accountType.description)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(isSelected ? .white.opacity(0.8) : .white.opacity(0.6))
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                // Selection indicator
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.4), lineWidth: 2)
                        .frame(width: 20, height: 20)
                    
                    if isSelected {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 12, height: 12)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        isSelected ?
                        Color.white.opacity(0.25) :
                        Color.white.opacity(0.15)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                isSelected ?
                                Color.white.opacity(0.4) :
                                Color.white.opacity(0.2),
                                lineWidth: 1
                            )
                    )
            )
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}

// Image Picker for profile photo
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                parent.selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.selectedImage = originalImage
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

#Preview {
    AccountSetupView()
} 
