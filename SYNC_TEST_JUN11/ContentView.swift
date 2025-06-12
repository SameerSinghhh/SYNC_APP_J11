//
//  ContentView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    @State private var pulseIcon = false
    @State private var buttonPressed = false
    @State private var showLoginView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Multiple overlapping animated gradients for smooth blending
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
                
                // Second gradient layer with different colors and timing
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
                
                // Third gradient layer for additional smoothness
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
                
                // Floating particles effect
                ForEach(0..<15, id: \.self) { index in
                    FloatingParticle(delay: Double(index) * 0.3)
                }
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    // Main content area
                    VStack(spacing: 40) {
                        // App icon with animation
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(0.3),
                                            Color.white.opacity(0.1)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 140, height: 140)
                                .blur(radius: 1)
                            
                            // Circular sync/refresh icon to match the provided logo
                            ZStack {
                                // Outer circle
                                Circle()
                                    .stroke(Color.white, lineWidth: 8)
                                    .frame(width: 80, height: 80)
                                
                                // Inner curved arrows forming sync icon
                                Path { path in
                                    let center = CGPoint(x: 40, y: 40)
                                    let radius: CGFloat = 25
                                    
                                    // First curved arrow (top-right to bottom-left)
                                    path.addArc(center: center, radius: radius, startAngle: .degrees(-45), endAngle: .degrees(135), clockwise: false)
                                    
                                    // Arrow head for first curve
                                    path.move(to: CGPoint(x: center.x - radius * cos(.pi * 3/4), y: center.y + radius * sin(.pi * 3/4)))
                                    path.addLine(to: CGPoint(x: center.x - radius * cos(.pi * 3/4) - 8, y: center.y + radius * sin(.pi * 3/4) - 3))
                                    path.move(to: CGPoint(x: center.x - radius * cos(.pi * 3/4), y: center.y + radius * sin(.pi * 3/4)))
                                    path.addLine(to: CGPoint(x: center.x - radius * cos(.pi * 3/4) - 3, y: center.y + radius * sin(.pi * 3/4) + 8))
                                }
                                .stroke(Color.white, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                                .frame(width: 80, height: 80)
                                
                                Path { path in
                                    let center = CGPoint(x: 40, y: 40)
                                    let radius: CGFloat = 25
                                    
                                    // Second curved arrow (bottom-left to top-right)
                                    path.addArc(center: center, radius: radius, startAngle: .degrees(135), endAngle: .degrees(315), clockwise: false)
                                    
                                    // Arrow head for second curve
                                    path.move(to: CGPoint(x: center.x + radius * cos(.pi * 3/4), y: center.y - radius * sin(.pi * 3/4)))
                                    path.addLine(to: CGPoint(x: center.x + radius * cos(.pi * 3/4) + 8, y: center.y - radius * sin(.pi * 3/4) + 3))
                                    path.move(to: CGPoint(x: center.x + radius * cos(.pi * 3/4), y: center.y - radius * sin(.pi * 3/4)))
                                    path.addLine(to: CGPoint(x: center.x + radius * cos(.pi * 3/4) + 3, y: center.y - radius * sin(.pi * 3/4) - 8))
                                }
                                .stroke(Color.white, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                                .frame(width: 80, height: 80)
                            }
                            .scaleEffect(pulseIcon ? 1.1 : 1.0)
                            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: pulseIcon)
                            .onAppear {
                                pulseIcon = true
                            }
                        }
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                        
                        // Welcome text
                        VStack(spacing: 12) {
                            Text("SYNC")
                                .font(.system(size: 42, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Connected Through Sound")
                                .font(.system(size: 18, weight: .light))
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    Spacer()
                    
                    // Sign in button at bottom
                    VStack(spacing: 20) {

                        
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                buttonPressed.toggle()
                            }
                            
                            // Reset button animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                buttonPressed = false
                            }
                            
                            // Navigate to login view
                            showLoginView = true
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 20, weight: .medium))
                                
                                Text("Sign In or Create Account")
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
                                                Color.white.opacity(0.25),
                                                Color.white.opacity(0.15)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 28)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    )
                            )
                            .scaleEffect(buttonPressed ? 0.95 : 1.0)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal, 32)
                        
                        // Continue as Guest option
                        Button(action: {
                            // Handle continue as guest action here
                            print("Continue as Guest tapped")
                        }) {
                            Text("Continue as Guest")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .underline()
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showLoginView) {
                LoginView()
            }
        }
    }
}

struct FloatingParticle: View {
    @State private var moveUp = false
    @State private var opacity = 0.0
    let delay: Double
    
    var body: some View {
        Circle()
            .fill(Color.white.opacity(0.6))
            .frame(width: CGFloat.random(in: 3...8), height: CGFloat.random(in: 3...8))
            .offset(
                x: CGFloat.random(in: -150...150),
                y: moveUp ? -800 : 400
            )
            .opacity(opacity)
            .onAppear {
                withAnimation(.linear(duration: Double.random(in: 8...12)).delay(delay).repeatForever(autoreverses: false)) {
                    moveUp = true
                }
                
                withAnimation(.easeIn(duration: 1).delay(delay)) {
                    opacity = 1.0
                }
                
                withAnimation(.easeOut(duration: 1).delay(delay + Double.random(in: 6...10))) {
                    opacity = 0.0
                }
            }
    }
}

#Preview {
    ContentView()
}
