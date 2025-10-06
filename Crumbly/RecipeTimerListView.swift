import SwiftUI

@available(iOS 14.0, *)
struct RecipeTimerListView: View {
    
    @ObservedObject var dataStore: RecipeDataStore
    @State private var searchText = ""
    @State private var showingAddView = false
    
    var filteredTimers: [RecipeTimer] {
        if searchText.isEmpty {
            return dataStore.timers
        } else {
            return dataStore.timers.filter { timer in
                timer.label.localizedCaseInsensitiveContains(searchText) ||
                timer.timerType.localizedCaseInsensitiveContains(searchText) ||
                timer.note.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
            VStack(spacing: 0) {
                RecipeTimerSearchBarView(searchText: $searchText)
                
                if filteredTimers.isEmpty {
                    RecipeTimerNoDataView()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredTimers) { timer in
                                NavigationLink(destination: RecipeTimerDetailView(timer: timer, dataStore: dataStore)) {
                                    RecipeTimerListRowView(timer: timer)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .onLongPressGesture {
                                    deleteTimer(timer)
                                }
                            }
                        }
                        .padding()
                    }
                }
                
                Spacer()
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Recipe Timers", displayMode: .large)
            .navigationBarItems(
                trailing: Button(action: {
                    showingAddView = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.orange)
                }
            )
        
        .sheet(isPresented: $showingAddView) {
            RecipeTimerAddView(dataStore: dataStore)
        }
    }
    
    private func deleteTimer(_ timer: RecipeTimer) {
        withAnimation(.easeInOut(duration: 0.3)) {
            dataStore.deleteTimer(timer)
        }
    }
}

@available(iOS 14.0, *)
struct RecipeTimerSearchBarView: View {
    @Binding var searchText: String
    @State private var isSearching = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .medium))
                
                TextField("Search timers...", text: $searchText, onEditingChanged: { editing in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isSearching = editing
                    }
                })
                .textFieldStyle(PlainTextFieldStyle())
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSearching ? Color.orange : Color.clear, lineWidth: 2)
            )
            
            if isSearching {
                Button("Cancel") {
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isSearching = false
                    }
                }
                .foregroundColor(.orange)
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}

@available(iOS 14.0, *)
struct RecipeTimerListRowView: View {
    let timer: RecipeTimer
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
            
                        
                        Text(timer.label)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                    }
                    
                    HStack {
                        Image(systemName: timerTypeIcon(timer.timerType))
                            .font(.caption)
                            .foregroundColor(.orange)
                        
                        Text(timer.timerType)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(statusText)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(statusColor)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(statusColor.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(timer.durationMinutes)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("minutes")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            
            Divider()
                .padding(.horizontal)
            
            // Details grid
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                RecipeTimerListDetailItem(
                    icon: "bell.fill",
                    title: "Sound",
                    value: timer.soundName,
                    color: .blue
                )
                
                RecipeTimerListDetailItem(
                    icon: "exclamationmark.triangle.fill",
                    title: "Warning",
                    value: "\(timer.warningMinutes)m",
                    color: .yellow
                )
                
                RecipeTimerListDetailItem(
                    icon: "star.fill",
                    title: "Priority",
                    value: String(timer.priority),
                    color: .purple
                )
                
                RecipeTimerListDetailItem(
                    icon: "target",
                    title: "Accuracy",
                    value: timer.accuracyLevel,
                    color: .green
                )
                
                RecipeTimerListDetailItem(
                    icon: "gearshape.fill",
                    title: "Auto Start",
                    value: timer.autoStart ? "Yes" : "No",
                    color: .orange
                )
                
                RecipeTimerListDetailItem(
                    icon: "zzz",
                    title: "Snooze",
                    value: timer.snoozeEnabled ? "\(timer.snoozeDuration)m" : "Off",
                    color: .green
                )
            }
            .padding()
            
            if !timer.note.isEmpty || !timer.reminderNote.isEmpty {
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    if !timer.note.isEmpty {
                        HStack {
                            Image(systemName: "note.text")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text(timer.note)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                    
                    if !timer.reminderNote.isEmpty {
                        HStack {
                            Image(systemName: "bell.badge")
                                .font(.caption)
                                .foregroundColor(.orange)
                            
                            Text(timer.reminderNote)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                }
                .padding()
            }
            
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    Text("\(timer.minDuration)-\(timer.maxDuration)m range")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    if timer.vibration {
                        Image(systemName: "iphone.radiowaves.left.and.right")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    
                    if timer.autoStop {
                        Image(systemName: "stop.circle.fill")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    
                    Text(DateFormatter.shortTime.string(from: timer.createdAt))
                        .font(.caption2)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)

    }
    
    private var statusText: String {
        if timer.completed {
            return "Completed"
        } else if timer.cancelled {
            return "Cancelled"
        } else if timer.paused {
            return "Paused"
        } else if timer.isActive {
            return "Running"
        } else {
            return "Ready"
        }
    }
    
    private var statusColor: Color {
        if timer.completed {
            return .green
        } else if timer.cancelled {
            return .red
        } else if timer.paused {
            return .yellow
        } else if timer.isActive {
            return .blue
        } else {
            return .gray
        }
    }
    
    private func timerTypeIcon(_ type: String) -> String {
        switch type {
        case "Oven": return "flame.fill"
        case "Stovetop": return "circle.grid.cross.fill"
        case "Prep": return "knife.circle.fill"
        case "Rest": return "bed.double.fill"
        case "Chill": return "snowflake"
        case "Marinate": return "drop.fill"
        default: return "timer"
        }
    }
}

@available(iOS 14.0, *)
struct RecipeTimerListDetailItem: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(color)
                .frame(height: 16)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            Text(value)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(color.opacity(0.05))
        .cornerRadius(8)
    }
}

@available(iOS 14.0, *)
struct RecipeTimerNoDataView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            VStack(spacing: 16) {
                Image(systemName: "timer.square")
                    .font(.system(size: 80))
                    .foregroundColor(.orange.opacity(0.6))
                
                Text("No Timers Found")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Create your first recipe timer to get started with precise cooking timing")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            VStack(spacing: 12) {
                HStack(spacing: 16) {
                    RecipeTimerNoDataFeatureView(
                        icon: "bell.fill",
                        title: "Custom Alerts",
                        color: .blue
                    )
                    
                    RecipeTimerNoDataFeatureView(
                        icon: "gearshape.fill",
                        title: "Auto Controls",
                        color: .green
                    )
                }
                
                HStack(spacing: 16) {
                    RecipeTimerNoDataFeatureView(
                        icon: "paintbrush.fill",
                        title: "Color Coding",
                        color: .purple
                    )
                    
                    RecipeTimerNoDataFeatureView(
                        icon: "star.fill",
                        title: "Priority Levels",
                        color: .yellow
                    )
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

@available(iOS 14.0, *)
struct RecipeTimerNoDataFeatureView: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

@available(iOS 14.0, *)
extension DateFormatter {
    static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
