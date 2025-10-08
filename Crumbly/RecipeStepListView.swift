

import SwiftUI

@available(iOS 14.0, *)
struct RecipeStepListView: View {
    
    @ObservedObject var dataStore: RecipeDataStore
    @State private var searchText = ""
    @State private var showingAddView = false
    
    var filteredSteps: [RecipeStep] {
        if searchText.isEmpty {
            return dataStore.steps
        } else {
            return dataStore.steps.filter { step in
                step.instruction.localizedCaseInsensitiveContains(searchText) ||
                step.difficulty.localizedCaseInsensitiveContains(searchText) ||
                step.region.localizedCaseInsensitiveContains(searchText) ||
                step.skillLevel.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.95, green: 0.97, blue: 1.0), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    RecipeStepSearchBarView(searchText: $searchText)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    if filteredSteps.isEmpty {
                        RecipeStepNoDataView()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(filteredSteps) { step in
                                    NavigationLink(destination: RecipeStepDetailView(step: step)) {
                                        RecipeStepListRowView(step: step, onDelete: {
                                            deleteStep(step)
                                        })
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                        }
                    }
                }
            }
            .navigationBarTitle("Recipe Steps", displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                showingAddView = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(Color(red: 0.2, green: 0.5, blue: 1.0))
            })
            .sheet(isPresented: $showingAddView) {
                RecipeStepAddView(dataStore: dataStore)
            }
        
    }
    
    private func deleteStep(_ step: RecipeStep) {
        withAnimation {
            dataStore.deleteStep(step)
        }
    }
}

@available(iOS 14.0, *)
struct RecipeStepSearchBarView: View {
    @Binding var searchText: String
    @State private var isEditing = false
    
    var body: some View {
        HStack(spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.5))
                    .font(.system(size: 18, weight: .medium))
                
                TextField("Search steps, difficulty, region...", text: $searchText, onEditingChanged: { editing in
                    withAnimation(.spring()) {
                        isEditing = editing
                    }
                })
                .foregroundColor(.primary)
                .font(.system(size: 16))
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.65))
                            .font(.system(size: 18))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
            
            if isEditing {
                Button(action: {
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                        .foregroundColor(Color(red: 0.2, green: 0.5, blue: 1.0))
                        .font(.system(size: 16, weight: .medium))
                }
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.vertical, 8)
    }
}

@available(iOS 14.0, *)
struct RecipeStepListRowView: View {
    let step: RecipeStep
    let onDelete: () -> Void
    @State private var offset: CGFloat = 0
    @State private var isSwiped = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            // Delete button
            HStack {
                Spacer()
                Button(action: {
                    withAnimation { onDelete() }
                }) {
                    VStack {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 22))
                        Text("Delete")
                            .font(.system(size: 12, weight: .medium))
                    }
                    .foregroundColor(.white)
                    .frame(width: 80)
                }
                .frame(maxHeight: .infinity) // dynamic height
                .background(Color.red)
                .cornerRadius(16)
            }
            
            // Main content
            HStack(spacing: 0) {
                // Accent bar
                RoundedRectangle(cornerRadius: 16)
                    .fill(difficultyGradient(step.difficulty))
                    .frame(width: 6)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Header
                    HStack {
                        Text("Step \(step.order)")
                            .font(.headline)
                        if step.isOptional {
                            Text("Optional")
                                .font(.caption2)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(6)
                        }
                        Spacer()
                        Text(step.difficulty.capitalized)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(difficultyColor(step.difficulty))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    // Instruction
                    Text(step.instruction)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true) // allow wrapping
                    
                    // Tips, Notes, Safety
                    if !step.tip.isEmpty {
                        labelRow(icon: "lightbulb.fill", text: step.tip, color: .yellow)
                    }
                    if !step.note.isEmpty {
                        labelRow(icon: "note.text", text: step.note, color: .blue)
                    }
                    if !step.safetyNotes.isEmpty {
                        labelRow(icon: "exclamationmark.triangle.fill", text: step.safetyNotes, color: .red)
                    }
                    
                    // Info badges
                    WrapHStack {
                        infoBadge("clock.fill", "\(step.estimatedMinutes)m", .orange)
                        infoBadge("timer", "\(step.timerMinutes)m", .purple)
                        infoBadge("pause.circle.fill", "\(step.restMinutes)m", .gray)
                        infoBadge("repeat", "\(step.repeatCount)x", .blue)
                        infoBadge("flame.fill", "\(step.caloriesBurned) cal", .red)
                        infoBadge("star.fill", "\(Int(step.successRate))%", .yellow)
                    }
                    
                    // Tools & Skills
                    if !step.requiredTools.isEmpty {
                        labelRow(icon: "wrench.fill", text: step.requiredTools.joined(separator: ", "), color: .gray)
                    }
                    if !step.toolHints.isEmpty {
                        labelRow(icon: "questionmark.circle.fill", text: step.toolHints.joined(separator: ", "), color: .orange)
                    }
                    labelRow(icon: "person.fill", text: step.skillLevel, color: .green)
                    
                    // Media, Music, Region, Style
                    WrapHStack {
                        if !step.videoURL.isEmpty {
                            infoBadge("play.circle.fill", "Video", .blue)
                        }
                        if !step.backgroundMusic.isEmpty {
                            infoBadge("music.note", step.backgroundMusic, .pink)
                        }
                        if !step.soundEffect.isEmpty {
                            infoBadge("speaker.wave.2.fill", step.soundEffect, .purple)
                        }
                        if !step.region.isEmpty {
                            infoBadge("globe", step.region, .green)
                        }
                        if !step.style.isEmpty {
                            infoBadge("paintbrush.fill", step.style, .red)
                        }
                    }
                    
                    // Linked Steps, Mistakes, Alternatives
                    if !step.linkedStepIDs.isEmpty {
                        labelRow(icon: "link", text: "Links: \(step.linkedStepIDs.count)", color: .blue)
                    }
                    if !step.commonMistakes.isEmpty {
                        labelRow(icon: "xmark.octagon.fill", text: step.commonMistakes.prefix(2).joined(separator: ", "), color: .red)
                    }
                    if !step.alternatives.isEmpty {
                        labelRow(icon: "arrow.triangle.2.circlepath", text: step.alternatives.prefix(2).joined(separator: ", "), color: .green)
                    }
                    
                    // Status flags
                    HStack {
                        if step.isCritical {
                            infoBadge("exclamationmark.triangle.fill", "Critical", .red)
                        }
                        if step.completed {
                            infoBadge("checkmark.circle.fill", "Completed", .green)
                        }
                    }
                    
                    // Created & Updated
                    HStack {
                        Text("Created: \(step.createdAt, formatter: dateFormatter)")
                        Spacer()
                        Text("Updated: \(step.updatedAt, formatter: dateFormatter)")
                    }
                    .font(.caption2)
                    .foregroundColor(.gray)
                }
                .padding(16)
            }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .onChanged { g in if g.translation.width < 0 { offset = g.translation.width } }
                    .onEnded { g in
                        withAnimation(.spring()) {
                            if g.translation.width < -50 {
                                offset = -80; isSwiped = true
                            } else {
                                offset = 0; isSwiped = false
                            }
                        }
                    }
            )
        }
        .fixedSize(horizontal: false, vertical: true) // dynamic vertical size
    }
    
    // Helpers
    private func infoBadge(_ icon: String, _ text: String, _ color: Color) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon).font(.caption2)
            Text(text).font(.caption2)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.15))
        .foregroundColor(color)
        .cornerRadius(6)
    }
    
    private func labelRow(icon: String, text: String, color: Color) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon).font(.caption2).foregroundColor(color)
            Text(text).font(.caption2).foregroundColor(.secondary)
        }
    }
    
    private func difficultyColor(_ difficulty: String) -> Color {
        switch difficulty.lowercased() {
        case "easy": return .green
        case "medium": return .orange
        case "hard": return .red
        default: return .gray
        }
    }
    
    private func difficultyGradient(_ difficulty: String) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [difficultyColor(difficulty), difficultyColor(difficulty).opacity(0.6)]),
            startPoint: .top, endPoint: .bottom
        )
    }
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .short
        return df
    }
}

// MARK: - Flexible HStack that wraps items
@available(iOS 14.0, *)
struct WrapHStack<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) { content() }
        }
    }
}


@available(iOS 14.0, *)
struct RecipeStepListInfoBadge: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 12))
            Text(text)
                .font(.system(size: 12, weight: .semibold))
        }
        .foregroundColor(color)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(color.opacity(0.15))
        .cornerRadius(8)
    }
}

@available(iOS 14.0, *)
struct RecipeStepNoDataView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.9, green: 0.95, blue: 1.0),
                            Color(red: 0.8, green: 0.9, blue: 1.0)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 140, height: 140)
                
                Image(systemName: "list.bullet.clipboard")
                    .font(.system(size: 60))
                    .foregroundColor(Color(red: 0.2, green: 0.5, blue: 1.0))
            }
            
            VStack(spacing: 12) {
                Text("No Recipe Steps Yet")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("Tap the + button to create your first cooking step")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
        }
    }
}
