//
//  MusicianAvailabilityView.swift
//  SYNC_TEST_JUN11
//
//  Created by Sameer Singh on 6/11/25.
//

import SwiftUI

struct MusicianAvailabilityView: View {
    @State private var animateGradient1 = false
    @State private var animateGradient2 = false
    @State private var animateGradient3 = false
    @State private var continueButtonPressed = false
    @State private var skipButtonPressed = false
    @State private var selectedTab = 0
    @Environment(\.dismiss) private var dismiss
    
    // Availability states
    @State private var selectedDays: Set<WeekDay> = []
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var isAvailableWeekends = true
    @State private var minimumBookingHours = 2.0
    @State private var advanceBookingDays = 7
    
    // Payment states
    @State private var hourlyRate = ""
    @State private var eventRate = ""
    @State private var selectedPaymentMethods: Set<PaymentMethod> = []
    @State private var bankAccountNumber = ""
    @State private var routingNumber = ""
    @State private var paypalEmail = ""
    @State private var venmoUsername = ""
    
    let weekDays = WeekDay.allCases
    let paymentMethods = PaymentMethod.allCases
    
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
                        
                        // Progress indicator (step 4 of 5)
                        HStack(spacing: 4) {
                            ForEach(0..<3, id: \.self) { _ in
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 8, height: 8)
                            }
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 8, height: 8)
                            
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Main content
                    VStack(spacing: 32) {
                        // Header
                        VStack(spacing: 16) {
                            Text("Availability & Payments")
                                .font(.system(size: 28, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Set your schedule and payment preferences")
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
                                    Image(systemName: "calendar")
                                        .font(.system(size: 20, weight: .medium))
                                    
                                    Text("Availability")
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
                                    Image(systemName: "creditcard")
                                        .font(.system(size: 20, weight: .medium))
                                    
                                    Text("Payments")
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
                            AvailabilitySection(
                                minimumBookingHours: $minimumBookingHours,
                                advanceBookingDays: $advanceBookingDays
                            )
                        } else {
                            PaymentSection(
                                hourlyRate: $hourlyRate,
                                eventRate: $eventRate,
                                selectedPaymentMethods: $selectedPaymentMethods,
                                bankAccountNumber: $bankAccountNumber,
                                routingNumber: $routingNumber,
                                paypalEmail: $paypalEmail,
                                venmoUsername: $venmoUsername
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
                                print("Availability and payments setup completed")
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
                                print("Availability and payments setup skipped")
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
        .onAppear {
            // Set default times
            let calendar = Calendar.current
            startTime = calendar.date(bySettingHour: 18, minute: 0, second: 0, of: Date()) ?? Date()
            endTime = calendar.date(bySettingHour: 23, minute: 0, second: 0, of: Date()) ?? Date()
        }
    }
}

// MARK: - Availability Section
struct AvailabilitySection: View {
    @State private var selectedDate = Date()
    @State private var availableDates: [Date: (start: Date, end: Date)] = [:]
    @State private var showTimePicker = false
    @State private var editingDate: Date? = nil
    @State private var showRecurringSheet = false
    @Binding var minimumBookingHours: Double
    @Binding var advanceBookingDays: Int
    
    @State private var recurringAvailabilities: [RecurringAvailability] = []
    
    var body: some View {
        VStack(spacing: 24) {
            // Calendar Picker
            VStack(alignment: .leading, spacing: 16) {
                Text("Select Available Dates")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                
                DatePicker("Available Dates", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .accentColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 32)
                    .onChange(of: selectedDate) { _, newDate in
                        // Add date with default time if not already present
                        let calendar = Calendar.current
                        let start = calendar.date(bySettingHour: 18, minute: 0, second: 0, of: newDate) ?? newDate
                        let end = calendar.date(bySettingHour: 23, minute: 0, second: 0, of: newDate) ?? newDate
                        if availableDates[newDate.stripTime()] == nil {
                            availableDates[newDate.stripTime()] = (start, end)
                        }
                    }
            }
            
            // List of selected dates with time pickers
            if !availableDates.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Your Availabilities")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.horizontal, 32)
                    
                    ForEach(availableDates.keys.sorted(), id: \.self) { date in
                        let times = availableDates[date]!
                        HStack {
                            Text(date.formatted(date: .abbreviated, time: .omitted))
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(action: { editingDate = date; showTimePicker = true }) {
                                Text("\(times.start.formatted(date: .omitted, time: .shortened)) - \(times.end.formatted(date: .omitted, time: .shortened))")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white.opacity(0.15))
                                    )
                            }
                            .sheet(isPresented: $showTimePicker) {
                                if let editingDate = editingDate {
                                    TimeRangePicker(
                                        date: editingDate,
                                        start: availableDates[editingDate]?.start ?? editingDate,
                                        end: availableDates[editingDate]?.end ?? editingDate
                                    ) { newStart, newEnd in
                                        availableDates[editingDate] = (newStart, newEnd)
                                    }
                                }
                            }
                            
                            Button(action: { availableDates.removeValue(forKey: date) }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white.opacity(0.6))
                            }
                        }
                        .padding(.horizontal, 32)
                    }
                }
            }
            
            // Recurring availability
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Recurring Availability")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                    Spacer()
                    Button(action: { showRecurringSheet = true }) {
                        HStack(spacing: 6) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.white)
                            Text("Add")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.15))
                        )
                    }
                }
                .padding(.horizontal, 32)
                
                ForEach(recurringAvailabilities) { recurring in
                    HStack {
                        Text("Every \(recurring.day.fullName)")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(recurring.start.formatted(date: .omitted, time: .shortened)) - \(recurring.end.formatted(date: .omitted, time: .shortened))")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.15))
                            )
                        Button(action: {
                            if let idx = recurringAvailabilities.firstIndex(where: { $0.id == recurring.id }) {
                                recurringAvailabilities.remove(at: idx)
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                    .padding(.horizontal, 32)
                }
            }
            
            // Minimum booking hours
            VStack(alignment: .leading, spacing: 8) {
                Text("Minimum Booking Duration")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                
                HStack {
                    Text("\(Int(minimumBookingHours)) hours")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    Slider(value: $minimumBookingHours, in: 1...8, step: 1)
                        .accentColor(.white.opacity(0.8))
                }
                .padding(.horizontal, 32)
            }
            
            // Advance booking days
            VStack(alignment: .leading, spacing: 8) {
                Text("Advance Booking Notice")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                
                HStack {
                    Text("\(advanceBookingDays) days")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    Slider(value: Binding(
                        get: { Double(advanceBookingDays) },
                        set: { advanceBookingDays = Int($0) }
                    ), in: 1...30, step: 1)
                    .accentColor(.white.opacity(0.8))
                }
                .padding(.horizontal, 32)
            }
        }
        .sheet(isPresented: $showRecurringSheet) {
            AddRecurringAvailabilitySheet(recurringAvailabilities: $recurringAvailabilities)
        }
    }
}

// Helper for stripping time from Date
extension Date {
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: components) ?? self
    }
}

// MARK: - Recurring Availability Model
struct RecurringAvailability: Identifiable, Equatable {
    let id = UUID()
    let day: WeekDay
    let start: Date
    let end: Date
}

// MARK: - Time Range Picker Sheet
struct TimeRangePicker: View {
    let date: Date
    @State var start: Date
    @State var end: Date
    var onSave: (Date, Date) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Set Time Range")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 32)
            
            DatePicker("Start", selection: $start, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .colorScheme(.dark)
                .padding(.horizontal, 32)
            
            DatePicker("End", selection: $end, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .colorScheme(.dark)
                .padding(.horizontal, 32)
            
            Button("Save") {
                onSave(start, end)
                dismiss()
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
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.4, blue: 0.9),
                    Color(red: 0.1, green: 0.6, blue: 0.8),
                    Color(red: 0.3, green: 0.5, blue: 0.8)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}

// MARK: - Add Recurring Availability Sheet
struct AddRecurringAvailabilitySheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var recurringAvailabilities: [RecurringAvailability]
    @State private var selectedDay: WeekDay = .monday
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Add Recurring Availability")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 32)
            
            Picker("Day", selection: $selectedDay) {
                ForEach(WeekDay.allCases, id: \.self) { day in
                    Text(day.fullName).tag(day)
                }
            }
            .pickerStyle(.wheel)
            .padding(.horizontal, 32)
            
            DatePicker("Start", selection: $startTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .colorScheme(.dark)
                .padding(.horizontal, 32)
            
            DatePicker("End", selection: $endTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .colorScheme(.dark)
                .padding(.horizontal, 32)
            
            Button("Add") {
                let newRecurring = RecurringAvailability(day: selectedDay, start: startTime, end: endTime)
                recurringAvailabilities.append(newRecurring)
                dismiss()
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
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.4, blue: 0.9),
                    Color(red: 0.1, green: 0.6, blue: 0.8),
                    Color(red: 0.3, green: 0.5, blue: 0.8)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}

// MARK: - Payment Section
struct PaymentSection: View {
    @Binding var hourlyRate: String
    @Binding var eventRate: String
    @Binding var selectedPaymentMethods: Set<PaymentMethod>
    @Binding var bankAccountNumber: String
    @Binding var routingNumber: String
    @Binding var paypalEmail: String
    @Binding var venmoUsername: String
    
    var body: some View {
        VStack(spacing: 24) {
            // Rates section
            VStack(alignment: .leading, spacing: 16) {
                Text("Your Rates")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hourly Rate")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                        
                        HStack {
                            Text("$")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                            
                            TextField("150", text: $hourlyRate)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .keyboardType(.numberPad)
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
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Event Rate")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                        
                        HStack {
                            Text("$")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                            
                            TextField("500", text: $eventRate)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .keyboardType(.numberPad)
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
            }
            
            // Payment methods selection
            VStack(alignment: .leading, spacing: 16) {
                Text("Payment Methods")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    ForEach(PaymentMethod.allCases, id: \.self) { method in
                        PaymentMethodCard(
                            method: method,
                            isSelected: selectedPaymentMethods.contains(method)
                        ) {
                            togglePaymentMethod(method)
                        }
                    }
                }
                .padding(.horizontal, 32)
            }
            
            // Payment details based on selected methods
            if selectedPaymentMethods.contains(.bankTransfer) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Bank Details")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                    
                    VStack(spacing: 12) {
                        TextField("Account Number", text: $bankAccountNumber)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .placeholder(when: bankAccountNumber.isEmpty) {
                                Text("Account Number")
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
                        
                        TextField("Routing Number", text: $routingNumber)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .placeholder(when: routingNumber.isEmpty) {
                                Text("Routing Number")
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
                }
            }
            
            if selectedPaymentMethods.contains(.paypal) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("PayPal Email")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                    
                    TextField("your@email.com", text: $paypalEmail)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .placeholder(when: paypalEmail.isEmpty) {
                            Text("your@email.com")
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
                        .padding(.horizontal, 32)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
            }
            
            if selectedPaymentMethods.contains(.venmo) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Venmo Username")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                    
                    TextField("@username", text: $venmoUsername)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .placeholder(when: venmoUsername.isEmpty) {
                            Text("@username")
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
                        .padding(.horizontal, 32)
                        .textInputAutocapitalization(.never)
                }
            }
        }
    }
    
    private func togglePaymentMethod(_ method: PaymentMethod) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            if selectedPaymentMethods.contains(method) {
                selectedPaymentMethods.remove(method)
            } else {
                selectedPaymentMethods.insert(method)
            }
        }
    }
}

// MARK: - Day Selection Card
struct DaySelectionCard: View {
    let day: WeekDay
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(day.shortName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.7))
                
                Text(day.fullName)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(isSelected ? .white.opacity(0.8) : .white.opacity(0.5))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.white.opacity(0.25) : Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.white.opacity(0.4) : Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}

// MARK: - Payment Method Card
struct PaymentMethodCard: View {
    let method: PaymentMethod
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: method.icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.7))
                    .frame(width: 24, height: 24)
                
                Text(method.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.8))
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.green)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.white.opacity(0.25) : Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.white.opacity(0.4) : Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
            .scaleEffect(isSelected ? 1.02 : 1.0)
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}

// MARK: - Data Models
enum WeekDay: String, CaseIterable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    
    var shortName: String {
        switch self {
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        case .sunday: return "Sun"
        }
    }
    
    var fullName: String {
        return self.rawValue
    }
}

enum PaymentMethod: String, CaseIterable {
    case cash = "Cash"
    case bankTransfer = "Bank Transfer"
    case paypal = "PayPal"
    case venmo = "Venmo"
    case zelle = "Zelle"
    case applePay = "Apple Pay"
    
    var name: String {
        return self.rawValue
    }
    
    var icon: String {
        switch self {
        case .cash: return "dollarsign.circle"
        case .bankTransfer: return "building.columns"
        case .paypal: return "p.circle"
        case .venmo: return "v.circle"
        case .zelle: return "z.circle"
        case .applePay: return "applelogo"
        }
    }
}

#Preview {
    MusicianAvailabilityView()
} 