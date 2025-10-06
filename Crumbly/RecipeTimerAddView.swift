import SwiftUI

@available(iOS 14.0, *)
struct RecipeTimerAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var dataStore: RecipeDataStore
    
    @State private var stepID = UUID()
    @State private var durationMinutes = 0
    @State private var note = ""
    @State private var soundName = "Bell"
    @State private var vibration = true
    @State private var autoStart = false
    @State private var autoStop = true
    @State private var warningMinutes = 2
    @State private var snoozeEnabled = false
    @State private var snoozeDuration = 5
    @State private var label = ""
    @State private var colorHex = "#FF4500"
    @State private var priority = 1
    @State private var reminderNote = ""
    @State private var timerType = "Oven"
    @State private var accuracyLevel = "High"
    @State private var maxDuration = 60
    @State private var minDuration = 1
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isSuccess = false
    
    let timerTypes = ["Oven", "Stovetop", "Prep", "Rest", "Chill", "Marinate"]
    let accuracyLevels = ["High", "Medium", "Low"]
    let soundOptions = ["Bell", "Chime", "Beep", "Ding", "Alert"]
    let colorOptions = ["#FF4500", "#32CD32", "#1E90FF", "#FFD700", "#FF69B4", "#8A2BE2"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    RecipeTimerAddHeaderView()
                    
                    LazyVStack(spacing: 20) {
                        RecipeTimerAddSectionHeaderView(title: "Timer Basics", icon: "timer", color: Color.orange)
                        
                        VStack(spacing: 16) {
                            RecipeTimerAddFieldView(
                                title: "Timer Label",
                                icon: "tag.fill",
                                content: AnyView(
                                    TextField("Enter timer name", text: $label)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                )
                            )
                            
                            RecipeTimerAddFieldView(
                                title: "Duration (Minutes)",
                                icon: "clock.fill",
                                content: AnyView(
                                    Stepper(value: $durationMinutes, in: 1...300) {
                                        Text("\(durationMinutes) min")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                    }
                                )
                            )
                            
                            RecipeTimerAddFieldView(
                                title: "Timer Type",
                                icon: "flame.fill",
                                content: AnyView(
                                    Picker("Timer Type", selection: $timerType) {
                                        ForEach(timerTypes, id: \.self) { type in
                                            Text(type).tag(type)
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                )
                            )
                        }
                        .padding(.horizontal)
                        
                        RecipeTimerAddSectionHeaderView(title: "Timing Controls", icon: "gearshape.fill", color: Color.blue)
                        
                        VStack(spacing: 16) {
                            RecipeTimerAddFieldView(
                                title: "Warning Time (Minutes)",
                                icon: "exclamationmark.triangle.fill",
                                content: AnyView(
                                    Stepper(value: $warningMinutes, in: 0...30) {
                                        Text("\(warningMinutes) min before")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                )
                            )
                            
                            RecipeTimerAddToggleView(title: "Auto Start", icon: "play.fill", isOn: $autoStart)
                            RecipeTimerAddToggleView(title: "Auto Stop", icon: "stop.fill", isOn: $autoStop)
                            RecipeTimerAddToggleView(title: "Enable Snooze", icon: "zzz", isOn: $snoozeEnabled)
                            
                            if snoozeEnabled {
                                RecipeTimerAddFieldView(
                                    title: "Snooze Duration",
                                    icon: "moon.fill",
                                    content: AnyView(
                                        Stepper(value: $snoozeDuration, in: 1...15) {
                                            Text("\(snoozeDuration) min")
                                                .font(.headline)
                                        }
                                    )
                                )
                            }
                        }
                        .padding(.horizontal)
                        
                        RecipeTimerAddSectionHeaderView(title: "Alerts & Notifications", icon: "bell.fill", color: Color.green)
                        
                        VStack(spacing: 16) {
                            RecipeTimerAddFieldView(
                                title: "Sound",
                                icon: "speaker.wave.2.fill",
                                content: AnyView(
                                    Picker("Sound", selection: $soundName) {
                                        ForEach(soundOptions, id: \.self) { sound in
                                            Text(sound).tag(sound)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                )
                            )
                            
                            RecipeTimerAddToggleView(title: "Vibration", icon: "iphone.radiowaves.left.and.right", isOn: $vibration)
                            
                            RecipeTimerAddFieldView(
                                title: "Reminder Note",
                                icon: "note.text",
                                content: AnyView(
                                    TextField("Optional reminder message", text: $reminderNote)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                )
                            )
                        }
                        .padding(.horizontal)
                        
                        RecipeTimerAddSectionHeaderView(title: "Customization", icon: "paintbrush.fill", color: Color.purple)
                        
                        VStack(spacing: 16) {
                            RecipeTimerAddColorPickerView(selectedColor: $colorHex, colors: colorOptions)
                            
                            RecipeTimerAddFieldView(
                                title: "Priority Level",
                                icon: "star.fill",
                                content: AnyView(
                                    Stepper(value: $priority, in: 1...5) {
                                        HStack {
                                            ForEach(1...priority, id: \.self) { _ in
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.yellow)
                                            }
                                            ForEach(priority+1...5, id: \.self) { _ in
                                                Image(systemName: "star")
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                )
                            )
                            
                            RecipeTimerAddFieldView(
                                title: "Accuracy Level",
                                icon: "target",
                                content: AnyView(
                                    Picker("Accuracy", selection: $accuracyLevel) {
                                        ForEach(accuracyLevels, id: \.self) { level in
                                            Text(level).tag(level)
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                )
                            )
                        }
                        .padding(.horizontal)
                        
                        RecipeTimerAddSectionHeaderView(title: "Duration Limits", icon: "slider.horizontal.3", color: Color.red)
                        
                        VStack(spacing: 16) {
                            RecipeTimerAddFieldView(
                                title: "Minimum Duration",
                                icon: "minus.circle.fill",
                                content: AnyView(
                                    Stepper(value: $minDuration, in: 1...60) {
                                        Text("\(minDuration) min")
                                            .font(.headline)
                                    }
                                )
                            )
                            
                            RecipeTimerAddFieldView(
                                title: "Maximum Duration",
                                icon: "plus.circle.fill",
                                content: AnyView(
                                    Stepper(value: $maxDuration, in: 60...600) {
                                        Text("\(maxDuration) min")
                                            .font(.headline)
                                    }
                                )
                            )
                            
                            RecipeTimerAddFieldView(
                                title: "Notes",
                                icon: "text.alignleft",
                                content: AnyView(
                                    TextField("Additional notes about this timer", text: $note)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                )
                            )
                        }
                        .padding(.horizontal)
                        
                        RecipeTimerAddSaveButtonView(action: saveTimer)
                            .padding(.top, 30)
                    }
                    .padding(.bottom, 30)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("New Timer", displayMode: .large)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveTimer()
                }
                .font(.headline)
                .foregroundColor(.orange)
            )
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(isSuccess ? "Success!" : "Validation Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if isSuccess {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
    
    private func saveTimer() {
        var errors: [String] = []
        
        if label.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("Timer label is required")
        }
        
        if durationMinutes <= 0 {
            errors.append("Duration must be greater than 0")
        }
        
        if minDuration >= maxDuration {
            errors.append("Minimum duration must be less than maximum duration")
        }
        
        if durationMinutes < minDuration || durationMinutes > maxDuration {
            errors.append("Duration must be between \(minDuration) and \(maxDuration) minutes")
        }
        
        if !errors.isEmpty {
            alertMessage = errors.joined(separator: "\n• ")
            isSuccess = false
            showingAlert = true
            return
        }
        
        let newTimer = RecipeTimer(
            stepID: stepID,
            durationMinutes: durationMinutes,
            note: note,
            createdAt: Date(),
            updatedAt: Date(),
            isActive: false,
            isRepeating: false,
            repeatInterval: 0,
            soundName: soundName,
            vibration: vibration,
            autoStart: autoStart,
            autoStop: autoStop,
            warningMinutes: warningMinutes,
            snoozeEnabled: snoozeEnabled,
            snoozeDuration: snoozeDuration,
            linkedTimers: [],
            label: label,
            colorHex: colorHex,
            priority: priority,
            completed: false,
            cancelled: false,
            paused: false,
            resumedAt: nil,
            pausedAt: nil,
            finishedAt: nil,
            nextTrigger: nil,
            history: [],
            deviceID: "Device001",
            userID: "User001",
            backupStatus: "Local",
            reminderNote: reminderNote,
            timerType: timerType,
            accuracyLevel: accuracyLevel,
            maxDuration: maxDuration,
            minDuration: minDuration
        )
        
        dataStore.addTimer(newTimer)
        alertMessage = "Timer '\(label)' has been created successfully!"
        isSuccess = true
        showingAlert = true
    }
}

@available(iOS 14.0, *)
struct RecipeTimerAddHeaderView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "timer")
                .font(.system(size: 60))
                .foregroundColor(.orange)
                .padding(.top, 20)
            
            Text("Create New Timer")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Set up a custom timer for your recipe steps")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.bottom, 30)
        .background(Color(.systemBackground))
    }
}

@available(iOS 14.0, *)
struct RecipeTimerAddSectionHeaderView: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Spacer()
            
            Rectangle()
                .fill(color.opacity(0.3))
                .frame(height: 2)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}

@available(iOS 14.0, *)
struct RecipeTimerAddFieldView: View {
    let title: String
    let icon: String
    let content: AnyView
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .frame(width: 20)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            content
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

@available(iOS 14.0, *)
struct RecipeTimerAddToggleView: View {
    let title: String
    let icon: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundColor(.orange)
                .frame(width: 20)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .orange))
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

@available(iOS 14.0, *)
struct RecipeTimerAddColorPickerView: View {
    @Binding var selectedColor: String
    let colors: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "paintbrush.fill")
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .frame(width: 20)
                
                Text("Timer Color")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 12) {
                ForEach(colors, id: \.self) { colorHex in
                    Circle()
                        .fill(Color(hex: colorHex))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Circle()
                                .stroke(selectedColor == colorHex ? Color.primary : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            selectedColor = colorHex
                        }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

@available(iOS 14.0, *)
struct RecipeTimerAddSaveButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                
                Text("Create Timer")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.red]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(15)
            .shadow(color: Color.orange.opacity(0.3), radius: 5, x: 0, y: 3)
        }
        .padding(.horizontal)
    }
}

@available(iOS 14.0, *)
extension Color {
    init(hex1: String) {
        let hex = hex1.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
