

import SwiftUI

@available(iOS 14.0, *)
struct RecipeStepDetailView: View {
    let step: RecipeStep
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Hero Header
                RecipeStepDetailHeaderView(step: step)
                
                VStack(spacing: 20) {
                    // Status Cards
                    RecipeStepDetailStatusCardsView(step: step)
                    
                    // Instruction Section
                    RecipeStepDetailInstructionView(step: step)
                    
                    // Timing Grid
                    RecipeStepDetailTimingGridView(step: step)
                    
                    // Details Section
                    RecipeStepDetailInfoSectionView(
                        title: "Tips & Notes",
                        icon: "lightbulb.fill",
                        color: Color(red: 1.0, green: 0.8, blue: 0.0)
                    ) {
                        VStack(spacing: 12) {
                            RecipeStepDetailFieldRow(
                                label: "Tip",
                                value: step.tip,
                                icon: "lightbulb",
                                color: Color(red: 1.0, green: 0.8, blue: 0.0)
                            )
                            RecipeStepDetailFieldRow(
                                label: "Note",
                                value: step.note,
                                icon: "note.text",
                                color: Color(red: 0.5, green: 0.5, blue: 0.6)
                            )
                            RecipeStepDetailFieldRow(
                                label: "Safety Notes",
                                value: step.safetyNotes,
                                icon: "exclamationmark.shield",
                                color: Color(red: 1.0, green: 0.3, blue: 0.3)
                            )
                        }
                    }
                    
                    // Tools & Equipment
                    RecipeStepDetailInfoSectionView(
                        title: "Tools & Equipment",
                        icon: "wrench.and.screwdriver.fill",
                        color: Color(red: 0.5, green: 0.5, blue: 0.6)
                    ) {
                        VStack(spacing: 8) {
                            ForEach(step.requiredTools, id: \.self) { tool in
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color(red: 0.2, green: 0.8, blue: 0.4))
                                    Text(tool)
                                        .font(.system(size: 15))
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(Color(red: 0.97, green: 0.98, blue: 1.0))
                                .cornerRadius(10)
                            }
                            
                            if !step.toolHints.isEmpty {
                                Divider()
                                    .padding(.vertical, 4)
                                
                                ForEach(step.toolHints, id: \.self) { hint in
                                    HStack {
                                        Image(systemName: "info.circle")
                                            .foregroundColor(Color(red: 0.2, green: 0.5, blue: 1.0))
                                        Text(hint)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.6))
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    
                    // Performance Metrics
                    RecipeStepDetailInfoSectionView(
                        title: "Performance Metrics",
                        icon: "chart.bar.fill",
                        color: Color(red: 0.6, green: 0.3, blue: 1.0)
                    ) {
                        VStack(spacing: 12) {
                            HStack(spacing: 12) {
                                RecipeStepDetailMetricCard(
                                    icon: "flame.fill",
                                    value: "\(step.caloriesBurned)",
                                    label: "Calories Burned",
                                    color: Color(red: 1.0, green: 0.3, blue: 0.3)
                                )
                                
                                RecipeStepDetailMetricCard(
                                    icon: "star.fill",
                                    value: "\(Int(step.successRate))%",
                                    label: "Success Rate",
                                    color: Color(red: 1.0, green: 0.8, blue: 0.0)
                                )
                            }
                            
                            HStack(spacing: 12) {
                                RecipeStepDetailMetricCard(
                                    icon: "flag.fill",
                                    value: "\(step.priority)",
                                    label: "Priority",
                                    color: Color(red: 1.0, green: 0.4, blue: 0.0)
                                )
                                
                                RecipeStepDetailMetricCard(
                                    icon: "repeat.circle.fill",
                                    value: "\(step.repeatCount)",
                                    label: "Repeat Count",
                                    color: Color(red: 0.3, green: 0.6, blue: 1.0)
                                )
                            }
                        }
                    }
                    
                    // Cultural & Style
                    RecipeStepDetailInfoSectionView(
                        title: "Cultural & Style",
                        icon: "globe",
                        color: Color(red: 0.2, green: 0.7, blue: 0.9)
                    ) {
                        VStack(spacing: 12) {
                            RecipeStepDetailFieldRow(
                                label: "Region",
                                value: step.region,
                                icon: "map",
                                color: Color(red: 0.2, green: 0.7, blue: 0.9)
                            )
                            RecipeStepDetailFieldRow(
                                label: "Style",
                                value: step.style,
                                icon: "paintbrush",
                                color: Color(red: 0.8, green: 0.4, blue: 0.9)
                            )
                            RecipeStepDetailFieldRow(
                                label: "Skill Level",
                                value: step.skillLevel,
                                icon: "person",
                                color: Color(red: 0.6, green: 0.4, blue: 1.0)
                            )
                        }
                    }
                    
                    // Media & Audio
                    if !step.videoURL.isEmpty || !step.backgroundMusic.isEmpty || !step.soundEffect.isEmpty {
                        RecipeStepDetailInfoSectionView(
                            title: "Media & Audio",
                            icon: "play.circle.fill",
                            color: Color(red: 1.0, green: 0.3, blue: 0.6)
                        ) {
                            VStack(spacing: 12) {
                                if !step.videoURL.isEmpty {
                                    RecipeStepDetailFieldRow(
                                        label: "Video URL",
                                        value: step.videoURL,
                                        icon: "video",
                                        color: Color(red: 1.0, green: 0.3, blue: 0.6)
                                    )
                                }
                                if !step.backgroundMusic.isEmpty {
                                    RecipeStepDetailFieldRow(
                                        label: "Background Music",
                                        value: step.backgroundMusic,
                                        icon: "music.note",
                                        color: Color(red: 0.6, green: 0.3, blue: 1.0)
                                    )
                                }
                                if !step.soundEffect.isEmpty {
                                    RecipeStepDetailFieldRow(
                                        label: "Sound Effect",
                                        value: step.soundEffect,
                                        icon: "speaker.wave.3",
                                        color: Color(red: 0.3, green: 0.6, blue: 1.0)
                                    )
                                }
                            }
                        }
                    }
                    
                    // Common Mistakes & Alternatives
                    if !step.commonMistakes.isEmpty || !step.alternatives.isEmpty {
                        RecipeStepDetailInfoSectionView(
                            title: "Tips for Success",
                            icon: "checkmark.seal.fill",
                            color: Color(red: 0.2, green: 0.8, blue: 0.4)
                        ) {
                            VStack(alignment: .leading, spacing: 16) {
                                if !step.commonMistakes.isEmpty {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Common Mistakes")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(Color(red: 1.0, green: 0.3, blue: 0.3))
                                        
                                        ForEach(step.commonMistakes, id: \.self) { mistake in
                                            HStack(alignment: .top, spacing: 8) {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundColor(Color(red: 1.0, green: 0.3, blue: 0.3))
                                                    .font(.system(size: 14))
                                                Text(mistake)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.primary)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                
                                if !step.alternatives.isEmpty {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Alternatives")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(Color(red: 0.2, green: 0.8, blue: 0.4))
                                        
                                        ForEach(step.alternatives, id: \.self) { alternative in
                                            HStack(alignment: .top, spacing: 8) {
                                                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                                    .foregroundColor(Color(red: 0.2, green: 0.8, blue: 0.4))
                                                    .font(.system(size: 14))
                                                Text(alternative)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.primary)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    // Metadata
                    RecipeStepDetailInfoSectionView(
                        title: "Metadata",
                        icon: "info.circle.fill",
                        color: Color(red: 0.5, green: 0.5, blue: 0.6)
                    ) {
                        VStack(spacing: 12) {
                            RecipeStepDetailFieldRow(
                                label: "Created At",
                                value: formatDate(step.createdAt),
                                icon: "calendar",
                                color: Color(red: 0.5, green: 0.5, blue: 0.6)
                            )
                            RecipeStepDetailFieldRow(
                                label: "Updated At",
                                value: formatDate(step.updatedAt),
                                icon: "clock",
                                color: Color(red: 0.5, green: 0.5, blue: 0.6)
                            )
                            RecipeStepDetailFieldRow(
                                label: "Step ID",
                                value: step.id.uuidString,
                                icon: "number",
                                color: Color(red: 0.5, green: 0.5, blue: 0.6)
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
        }
        .background(Color(red: 0.97, green: 0.98, blue: 1.0))
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle("", displayMode: .inline)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

@available(iOS 14.0, *)
struct RecipeStepDetailHeaderView: View {
    let step: RecipeStep
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    difficultyColor(step.difficulty),
                    difficultyColor(step.difficulty).opacity(0.7)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 220)
            
            VStack(spacing: 16) {
                // Step number badge
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .shadow(color: Color.black.opacity(0.2), radius: 12, x: 0, y: 6)
                    
                    VStack(spacing: 4) {
                        Text("STEP")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(difficultyColor(step.difficulty))
                        Text("\(step.order)")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(difficultyColor(step.difficulty))
                    }
                }
                
                // Difficulty badge
                HStack(spacing: 8) {
                    Image(systemName: difficultyIcon(step.difficulty))
                        .font(.system(size: 16))
                    Text(step.difficulty)
                        .font(.system(size: 16, weight: .bold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.25))
                .cornerRadius(20)
            }
            .padding(.bottom, 30)
        }
    }
    
    private func difficultyColor(_ difficulty: String) -> Color {
        switch difficulty.lowercased() {
        case "easy":
            return Color(red: 0.2, green: 0.8, blue: 0.4)
        case "medium":
            return Color(red: 1.0, green: 0.7, blue: 0.0)
        case "hard":
            return Color(red: 1.0, green: 0.3, blue: 0.3)
        default:
            return Color(red: 0.5, green: 0.5, blue: 0.6)
        }
    }
    
    private func difficultyIcon(_ difficulty: String) -> String {
        switch difficulty.lowercased() {
        case "easy":
            return "leaf.fill"
        case "medium":
            return "bolt.fill"
        case "hard":
            return "flame.fill"
        default:
            return "circle.fill"
        }
    }
}

@available(iOS 14.0, *)
struct RecipeStepDetailStatusCardsView: View {
    let step: RecipeStep
    
    var body: some View {
        HStack(spacing: 12) {
            if step.isOptional {
                RecipeStepDetailStatusBadge(
                    icon: "questionmark.circle.fill",
                    text: "Optional",
                    color: Color(red: 0.5, green: 0.5, blue: 0.6)
                )
            }
            
            if step.isCritical {
                RecipeStepDetailStatusBadge(
                    icon: "exclamationmark.triangle.fill",
                    text: "Critical",
                    color: Color(red: 1.0, green: 0.4, blue: 0.0)
                )
            }
            
            if step.isAutomatable {
                RecipeStepDetailStatusBadge(
                    icon: "gearshape.2.fill",
                    text: "Automatable",
                    color: Color(red: 0.3, green: 0.7, blue: 0.5)
                )
            }
            
            if step.completed {
                RecipeStepDetailStatusBadge(
                    icon: "checkmark.circle.fill",
                    text: "Completed",
                    color: Color(red: 0.2, green: 0.8, blue: 0.4)
                )
            }
        }
        .padding(.top, 16)
    }
}

@available(iOS 14.0, *)
struct RecipeStepDetailStatusBadge: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 14))
            Text(text)
                .font(.system(size: 13, weight: .semibold))
        }
        .foregroundColor(color)
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(color.opacity(0.15))
        .cornerRadius(12)
    }
}

@available(iOS 14.0, *)
struct RecipeStepDetailInstructionView: View {
    let step: RecipeStep
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: "text.alignleft")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(red: 0.2, green: 0.5, blue: 1.0))
                
                Text("Instruction")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
            }
            
            Text(step.instruction)
                .font(.system(size: 16))
                .foregroundColor(.primary)
                .lineSpacing(6)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
        }
    }
}

@available(iOS 14.0, *)
struct RecipeStepDetailTimingGridView: View {
    let step: RecipeStep
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: "clock.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.2))
                
                Text("Timing")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
            }
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    RecipeStepDetailTimingCard(
                        icon: "timer",
                        value: "\(step.estimatedMinutes)",
                        label: "Estimated",
                        color: Color(red: 1.0, green: 0.6, blue: 0.2)
                    )
                    
                    RecipeStepDetailTimingCard(
                        icon: "alarm.fill",
                        value: "\(step.timerMinutes)",
                        label: "Timer",
                        color: Color(red: 1.0, green: 0.5, blue: 0.3)
                    )
                }
                
                HStack(spacing: 12) {
                    RecipeStepDetailTimingCard(
                        icon: "pause.circle.fill",
                        value: "\(step.restMinutes)",
                        label: "Rest",
                        color: Color(red: 1.0, green: 0.7, blue: 0.3)
                    )
                    
                    RecipeStepDetailTimingCard(
                        icon: "clock.arrow.circlepath",
                        value: "\(step.estimatedMinutes + step.restMinutes)",
                        label: "Total",
                        color: Color(red: 1.0, green: 0.8, blue: 0.2)
                    )
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
        }
    }
}

@available(iOS 14.0, *)
struct RecipeStepDetailTimingCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
            
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.6))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

@available(iOS 14.0, *)
struct RecipeStepDetailInfoSectionView<Content: View>: View {
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
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(color)
                
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
            }
            
            VStack(spacing: 12) {
                content
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
        }
    }
}

@available(iOS 14.0, *)
struct RecipeStepDetailFieldRow: View {
    let label: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.6))
                
                Text(value.isEmpty ? "Not specified" : value)
                    .font(.system(size: 15))
                    .foregroundColor(value.isEmpty ? Color(red: 0.7, green: 0.7, blue: 0.75) : .primary)
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color(red: 0.97, green: 0.98, blue: 1.0))
        .cornerRadius(12)
    }
}

@available(iOS 14.0, *)
struct RecipeStepDetailMetricCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.primary)
            
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.6))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(color.opacity(0.1))
        .cornerRadius(16)
    }
}
