import SwiftUI

@available(iOS 14.0, *)
struct RecipeStepAddView: View {
    
    @ObservedObject var dataStore: RecipeDataStore
    @Environment(\.presentationMode) var presentationMode
    
    // Required fields (15+)
    @State private var order: String = ""
    @State private var instruction: String = ""
    @State private var estimatedMinutes: String = ""
    @State private var timerMinutes: String = ""
    @State private var difficulty: String = "Easy"
    @State private var tip: String = ""
    @State private var note: String = ""
    @State private var caloriesBurned: String = ""
    @State private var restMinutes: String = ""
    @State private var repeatCount: String = ""
    @State private var priority: String = ""
    @State private var successRate: String = ""
    @State private var safetyNotes: String = ""
    @State private var region: String = ""
    @State private var style: String = ""
    @State private var skillLevel: String = "Beginner"
    @State private var requiredTools: String = ""
    @State private var videoURL: String = ""
    @State private var backgroundMusic: String = ""
    @State private var soundEffect: String = ""
    
    // Toggles
    @State private var isOptional: Bool = false
    @State private var isCritical: Bool = true
    @State private var isAutomatable: Bool = false
    @State private var completed: Bool = false
    
    // Alert
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let difficulties = ["Easy", "Medium", "Hard"]
    let skillLevels = ["Beginner", "Intermediate", "Advanced", "Expert"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.97, green: 0.98, blue: 1.0)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        RecipeStepAddHeaderView()
                        
                        // Basic Information Section
                        RecipeStepAddSectionView(title: "Basic Information", icon: "info.circle.fill", color: Color(red: 0.2, green: 0.5, blue: 1.0)) {
                            VStack(spacing: 16) {
                                RecipeStepAddFieldView(
                                    icon: "number.circle.fill",
                                    placeholder: "Step Order",
                                    text: $order,
                                    iconColor: Color(red: 0.2, green: 0.5, blue: 1.0),
                                    keyboardType: .numberPad
                                )
                                
                                RecipeStepAddTextEditorView(
                                    icon: "text.alignleft",
                                    placeholder: "Instruction",
                                    text: $instruction,
                                    iconColor: Color(red: 0.3, green: 0.6, blue: 1.0)
                                )
                                
                                RecipeStepAddPickerView(
                                    icon: "gauge.medium.fill",
                                    title: "Difficulty",
                                    selection: $difficulty,
                                    options: difficulties,
                                    iconColor: Color(red: 1.0, green: 0.6, blue: 0.2)
                                )
                                
                                RecipeStepAddPickerView(
                                    icon: "person.fill",
                                    title: "Skill Level",
                                    selection: $skillLevel,
                                    options: skillLevels,
                                    iconColor: Color(red: 0.6, green: 0.4, blue: 1.0)
                                )
                            }
                        }
                        
                        // Timing Section
                        RecipeStepAddSectionView(title: "Timing & Duration", icon: "clock.fill", color: Color(red: 1.0, green: 0.6, blue: 0.2)) {
                            VStack(spacing: 16) {
                                RecipeStepAddFieldView(
                                    icon: "timer",
                                    placeholder: "Estimated Minutes",
                                    text: $estimatedMinutes,
                                    iconColor: Color(red: 1.0, green: 0.6, blue: 0.2),
                                    keyboardType: .numberPad
                                )
                                
                                RecipeStepAddFieldView(
                                    icon: "alarm.fill",
                                    placeholder: "Timer Minutes",
                                    text: $timerMinutes,
                                    iconColor: Color(red: 1.0, green: 0.5, blue: 0.3),
                                    keyboardType: .numberPad
                                )
                                
                                RecipeStepAddFieldView(
                                    icon: "pause.circle.fill",
                                    placeholder: "Rest Minutes",
                                    text: $restMinutes,
                                    iconColor: Color(red: 1.0, green: 0.7, blue: 0.3),
                                    keyboardType: .numberPad
                                )
                                
                                RecipeStepAddFieldView(
                                    icon: "repeat.circle.fill",
                                    placeholder: "Repeat Count",
                                    text: $repeatCount,
                                    iconColor: Color(red: 1.0, green: 0.8, blue: 0.2),
                                    keyboardType: .numberPad
                                )
                            }
                        }
                        
                        // Details Section
                        RecipeStepAddSectionView(title: "Step Details", icon: "doc.text.fill", color: Color(red: 0.3, green: 0.7, blue: 0.5)) {
                            VStack(spacing: 16) {
                                RecipeStepAddTextEditorView(
                                    icon: "lightbulb.fill",
                                    placeholder: "Tip",
                                    text: $tip,
                                    iconColor: Color(red: 1.0, green: 0.8, blue: 0.0)
                                )
                                
                                RecipeStepAddTextEditorView(
                                    icon: "note.text",
                                    placeholder: "Note",
                                    text: $note,
                                    iconColor: Color(red: 0.5, green: 0.5, blue: 0.6)
                                )
                                
                                RecipeStepAddTextEditorView(
                                    icon: "exclamationmark.shield.fill",
                                    placeholder: "Safety Notes",
                                    text: $safetyNotes,
                                    iconColor: Color(red: 1.0, green: 0.3, blue: 0.3)
                                )
                                
                                RecipeStepAddFieldView(
                                    icon: "wrench.and.screwdriver.fill",
                                    placeholder: "Required Tools (comma separated)",
                                    text: $requiredTools,
                                    iconColor: Color(red: 0.5, green: 0.5, blue: 0.6)
                                )
                            }
                        }
                        
                        // Performance Section
                        RecipeStepAddSectionView(title: "Performance Metrics", icon: "chart.bar.fill", color: Color(red: 0.6, green: 0.3, blue: 1.0)) {
                            VStack(spacing: 16) {
                                RecipeStepAddFieldView(
                                    icon: "flame.fill",
                                    placeholder: "Calories Burned",
                                    text: $caloriesBurned,
                                    iconColor: Color(red: 1.0, green: 0.3, blue: 0.3),
                                    keyboardType: .numberPad
                                )
                                
                                RecipeStepAddFieldView(
                                    icon: "star.fill",
                                    placeholder: "Success Rate (0-100)",
                                    text: $successRate,
                                    iconColor: Color(red: 1.0, green: 0.8, blue: 0.0),
                                    keyboardType: .decimalPad
                                )
                                
                                RecipeStepAddFieldView(
                                    icon: "flag.fill",
                                    placeholder: "Priority (1-10)",
                                    text: $priority,
                                    iconColor: Color(red: 1.0, green: 0.4, blue: 0.0),
                                    keyboardType: .numberPad
                                )
                            }
                        }
                        
                        // Cultural & Style Section
                        RecipeStepAddSectionView(title: "Cultural & Style", icon: "globe", color: Color(red: 0.2, green: 0.7, blue: 0.9)) {
                            VStack(spacing: 16) {
                                RecipeStepAddFieldView(
                                    icon: "map.fill",
                                    placeholder: "Region",
                                    text: $region,
                                    iconColor: Color(red: 0.2, green: 0.7, blue: 0.9)
                                )
                                
                                RecipeStepAddFieldView(
                                    icon: "paintbrush.fill",
                                    placeholder: "Style",
                                    text: $style,
                                    iconColor: Color(red: 0.8, green: 0.4, blue: 0.9)
                                )
                            }
                        }
                        
                        // Media Section
                        RecipeStepAddSectionView(title: "Media & Audio", icon: "play.circle.fill", color: Color(red: 1.0, green: 0.3, blue: 0.6)) {
                            VStack(spacing: 16) {
                                RecipeStepAddFieldView(
                                    icon: "video.fill",
                                    placeholder: "Video URL",
                                    text: $videoURL,
                                    iconColor: Color(red: 1.0, green: 0.3, blue: 0.6)
                                )
                                
                                RecipeStepAddFieldView(
                                    icon: "music.note",
                                    placeholder: "Background Music",
                                    text: $backgroundMusic,
                                    iconColor: Color(red: 0.6, green: 0.3, blue: 1.0)
                                )
                                
                                RecipeStepAddFieldView(
                                    icon: "speaker.wave.3.fill",
                                    placeholder: "Sound Effect",
                                    text: $soundEffect,
                                    iconColor: Color(red: 0.3, green: 0.6, blue: 1.0)
                                )
                            }
                        }
                        
                        // Toggles Section
                        RecipeStepAddSectionView(title: "Options", icon: "switch.2", color: Color(red: 0.5, green: 0.5, blue: 0.6)) {
                            VStack(spacing: 12) {
                                RecipeStepAddToggleView(
                                    icon: "questionmark.circle.fill",
                                    title: "Optional Step",
                                    isOn: $isOptional,
                                    iconColor: Color(red: 0.5, green: 0.5, blue: 0.6)
                                )
                                
                                RecipeStepAddToggleView(
                                    icon: "exclamationmark.triangle.fill",
                                    title: "Critical Step",
                                    isOn: $isCritical,
                                    iconColor: Color(red: 1.0, green: 0.4, blue: 0.0)
                                )
                                
                                RecipeStepAddToggleView(
                                    icon: "gearshape.2.fill",
                                    title: "Automatable",
                                    isOn: $isAutomatable,
                                    iconColor: Color(red: 0.3, green: 0.7, blue: 0.5)
                                )
                                
                                RecipeStepAddToggleView(
                                    icon: "checkmark.circle.fill",
                                    title: "Completed",
                                    isOn: $completed,
                                    iconColor: Color(red: 0.2, green: 0.8, blue: 0.4)
                                )
                            }
                        }
                        
                        // Save Button
                        Button(action: saveStep) {
                            HStack(spacing: 12) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20))
                                Text("Save Recipe Step")
                                    .font(.system(size: 18, weight: .bold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.2, green: 0.5, blue: 1.0),
                                        Color(red: 0.3, green: 0.6, blue: 1.0)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                            .shadow(color: Color(red: 0.2, green: 0.5, blue: 1.0).opacity(0.4), radius: 12, x: 0, y: 6)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    }
                    .padding(.top, 16)
                }
            }
            .navigationBarTitle("New Recipe Step", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.6))
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        if alertTitle == "Success" {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                )
            }
        }
    }
    
    private func saveStep() {
        var errors: [String] = []
        
        // Validate required fields
        if order.isEmpty {
            errors.append("• Step Order is required")
        }
        if instruction.isEmpty {
            errors.append("• Instruction is required")
        }
        if estimatedMinutes.isEmpty {
            errors.append("• Estimated Minutes is required")
        }
        if timerMinutes.isEmpty {
            errors.append("• Timer Minutes is required")
        }
        if tip.isEmpty {
            errors.append("• Tip is required")
        }
        if note.isEmpty {
            errors.append("• Note is required")
        }
        if caloriesBurned.isEmpty {
            errors.append("• Calories Burned is required")
        }
        if restMinutes.isEmpty {
            errors.append("• Rest Minutes is required")
        }
        if repeatCount.isEmpty {
            errors.append("• Repeat Count is required")
        }
        if priority.isEmpty {
            errors.append("• Priority is required")
        }
        if successRate.isEmpty {
            errors.append("• Success Rate is required")
        }
        if safetyNotes.isEmpty {
            errors.append("• Safety Notes is required")
        }
        if region.isEmpty {
            errors.append("• Region is required")
        }
        if style.isEmpty {
            errors.append("• Style is required")
        }
        if requiredTools.isEmpty {
            errors.append("• Required Tools is required")
        }
        
        if !errors.isEmpty {
            alertTitle = "Missing Required Fields"
            alertMessage = "Please fill in the following fields:\n\n" + errors.joined(separator: "\n")
            showAlert = true
            return
        }
        
        // Create new step
        let newStep = RecipeStep(
            order: Int(order) ?? 0,
            instruction: instruction,
            estimatedMinutes: Int(estimatedMinutes) ?? 0,
            imageID: nil,
            videoURL: videoURL,
            timerMinutes: Int(timerMinutes) ?? 0,
            requiredTools: requiredTools.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) },
            createdAt: Date(),
            updatedAt: Date(),
            tip: tip,
            difficulty: difficulty,
            note: note,
            isOptional: isOptional,
            ingredientsUsed: [],
            caloriesBurned: Int(caloriesBurned) ?? 0,
            restMinutes: Int(restMinutes) ?? 0,
            repeatCount: Int(repeatCount) ?? 1,
            backgroundMusic: backgroundMusic,
            soundEffect: soundEffect,
            priority: Int(priority) ?? 1,
            isCritical: isCritical,
            successRate: Double(successRate) ?? 0.0,
            safetyNotes: safetyNotes,
            commonMistakes: [],
            alternatives: [],
            region: region,
            style: style,
            toolHints: [],
            skillLevel: skillLevel,
            isAutomatable: isAutomatable,
            linkedStepIDs: [],
            completed: completed
        )
        
        dataStore.addStep(newStep)
        
        alertTitle = "Success"
        alertMessage = "Recipe step has been saved successfully!"
        showAlert = true
    }
}

@available(iOS 14.0, *)
struct RecipeStepAddHeaderView: View {
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.2, green: 0.5, blue: 1.0),
                            Color(red: 0.3, green: 0.6, blue: 1.0)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 80, height: 80)
                    .shadow(color: Color(red: 0.2, green: 0.5, blue: 1.0).opacity(0.3), radius: 12, x: 0, y: 6)
                
                Image(systemName: "list.number")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
            }
            
            Text("Create Recipe Step")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.primary)
            
            Text("Fill in all the details below")
                .font(.system(size: 15))
                .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.6))
        }
        .padding(.vertical, 20)
    }
}

@available(iOS 14.0, *)
struct RecipeStepAddSectionView<Content: View>: View {
    let title: String
    let icon: String
    let color: Color
    let content: Content
    
    init(title: String, icon: String, color: Color, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(color)
                
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
            }
            .padding(.horizontal)
            
            VStack(spacing: 16) {
                content
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
            .padding(.horizontal)
        }
    }
}

@available(iOS 14.0, *)
struct RecipeStepAddFieldView: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    let iconColor: Color
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(placeholder)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.6))
                
                TextField("", text: $text)
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                    .keyboardType(keyboardType)
            }
        }
        .padding(14)
        .background(Color(red: 0.97, green: 0.98, blue: 1.0))
        .cornerRadius(14)
    }
}

@available(iOS 14.0, *)
struct RecipeStepAddTextEditorView: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    let iconColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.15))
                        .frame(width: 36, height: 36)
                    
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(iconColor)
                }
                
                Text(placeholder)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
            }
            
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text("Enter \(placeholder.lowercased())...")
                        .font(.system(size: 15))
                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.75))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                
                TextEditor(text: $text)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                    .frame(height: 80)
                    .padding(4)
            }
            .background(Color(red: 0.97, green: 0.98, blue: 1.0))
            .cornerRadius(12)
        }
    }
}

@available(iOS 14.0, *)
struct RecipeStepAddPickerView: View {
    let icon: String
    let title: String
    @Binding var selection: String
    let options: [String]
    let iconColor: Color
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.6))
                
                Picker("", selection: $selection) {
                    ForEach(options, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .font(.system(size: 16))
            }
            
            Spacer()
        }
        .padding(14)
        .background(Color(red: 0.97, green: 0.98, blue: 1.0))
        .cornerRadius(14)
    }
}

@available(iOS 14.0, *)
struct RecipeStepAddToggleView: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool
    let iconColor: Color
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(14)
        .background(Color(red: 0.97, green: 0.98, blue: 1.0))
        .cornerRadius(14)
    }
}
