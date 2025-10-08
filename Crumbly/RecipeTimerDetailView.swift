import SwiftUI

@available(iOS 14.0, *)
struct RecipeTimerDetailView: View {
    
    
    let timer: RecipeTimer
    @ObservedObject var dataStore: RecipeDataStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                RecipeTimerDetailHeaderView(timer: timer)
                
                LazyVStack(spacing: 20) {
                    RecipeTimerDetailTimingSection(timer: timer)
                    RecipeTimerDetailControlsSection(timer: timer)
                    RecipeTimerDetailAlertsSection(timer: timer)
                    RecipeTimerDetailCustomizationSection(timer: timer)
                    RecipeTimerDetailLimitsSection(timer: timer)
                    RecipeTimerDetailStatusSection(timer: timer)
                    RecipeTimerDetailMetadataSection(timer: timer)
                }
                .padding(.bottom, 30)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitle(timer.label, displayMode: .inline)
       
    }
}


@available(iOS 14.0, *)
struct RecipeTimerDetailHeaderView: View {
    let timer: RecipeTimer
    
    var body: some View {
        VStack(spacing: 20) {
            mainTimerView
            statusIndicatorView
        }
        .padding(.vertical, 30)
        .background(Color(.systemBackground))
    }
}

@available(iOS 14.0, *)
private extension RecipeTimerDetailHeaderView {
    
    var mainTimerView: some View {
        VStack(spacing: 12) {
            timerInfo
        }
    }
    
            
        var timerInfo: some View {
        VStack(spacing: 4) {
            Text(timer.label)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            
            HStack {
                Image(systemName: timerTypeIcon(timer.timerType))
                    .font(.subheadline)
                    .foregroundColor(.orange)
                
                Text(timer.timerType)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("•")
                    .foregroundColor(.secondary)
                
                Text(timer.accuracyLevel + " Accuracy")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    var statusIndicatorView: some View {
        HStack {
            Circle()
                .fill(statusColor)
                .frame(width: 12, height: 12)
            
            Text(statusText)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(statusColor)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(statusColor.opacity(0.1))
        .cornerRadius(20)
    }
}

@available(iOS 14.0, *)
private extension RecipeTimerDetailHeaderView {
    
    var statusText: String {
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
    
    var statusColor: Color {
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
    
    func timerTypeIcon(_ type: String) -> String {
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
struct RecipeTimerDetailTimingSection: View {
    let timer: RecipeTimer
    
    var body: some View {
        RecipeTimerDetailSectionView(
            title: "Timing Configuration",
            icon: "clock.fill",
            color: .blue
        ) {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                RecipeTimerDetailFieldRow(
                    icon: "clock.arrow.circlepath",
                    title: "Duration",
                    value: "\(timer.durationMinutes) minutes",
                    color: .blue
                )
                
                RecipeTimerDetailFieldRow(
                    icon: "exclamationmark.triangle.fill",
                    title: "Warning Time",
                    value: "\(timer.warningMinutes) min before",
                    color: .yellow
                )
                
                RecipeTimerDetailFieldRow(
                    icon: "repeat",
                    title: "Repeating",
                    value: timer.isRepeating ? "Every \(timer.repeatInterval)m" : "No",
                    color: .purple
                )
                
                RecipeTimerDetailFieldRow(
                    icon: "star.fill",
                    title: "Priority",
                    value: priorityText,
                    color: .orange
                )
            }
        }
    }
    
    private var priorityText: String {
        String(repeating: "★", count: timer.priority) + String(repeating: "☆", count: 5 - timer.priority)
    }
}

@available(iOS 14.0, *)
struct RecipeTimerDetailControlsSection: View {
    let timer: RecipeTimer
    
    var body: some View {
        RecipeTimerDetailSectionView(
            title: "Automation Controls",
            icon: "gearshape.2.fill",
            color: .green
        ) {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                RecipeTimerDetailToggleRow(
                    icon: "play.fill",
                    title: "Auto Start",
                    isEnabled: timer.autoStart,
                    color: .green
                )
                
                RecipeTimerDetailToggleRow(
                    icon: "stop.fill",
                    title: "Auto Stop",
                    isEnabled: timer.autoStop,
                    color: .red
                )
                
                RecipeTimerDetailToggleRow(
                    icon: "zzz",
                    title: "Snooze Enabled",
                    isEnabled: timer.snoozeEnabled,
                    color: .green
                )
                
                RecipeTimerDetailFieldRow(
                    icon: "moon.fill",
                    title: "Snooze Duration",
                    value: timer.snoozeEnabled ? "\(timer.snoozeDuration) min" : "Disabled",
                    color: .yellow
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct RecipeTimerDetailAlertsSection: View {
    let timer: RecipeTimer
    
    var body: some View {
        RecipeTimerDetailSectionView(
            title: "Alerts & Notifications",
            icon: "bell.fill",
            color: .orange
        ) {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    RecipeTimerDetailFieldRow(
                        icon: "speaker.wave.2.fill",
                        title: "Sound",
                        value: timer.soundName,
                        color: .blue
                    )
                    
                    RecipeTimerDetailToggleRow(
                        icon: "iphone.radiowaves.left.and.right",
                        title: "Vibration",
                        isEnabled: timer.vibration,
                        color: .purple
                    )
                }
                
                if !timer.reminderNote.isEmpty {
                    RecipeTimerDetailNoteRow(
                        icon: "bell.badge",
                        title: "Reminder Note",
                        content: timer.reminderNote,
                        color: .orange
                    )
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct RecipeTimerDetailCustomizationSection: View {
    let timer: RecipeTimer
    
    var body: some View {
        RecipeTimerDetailSectionView(
            title: "Customization",
            icon: "paintbrush.fill",
            color: .purple
        ) {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                HStack {
                    Image(systemName: "circle.fill")
                        .font(.title3)
                        .foregroundColor(.purple)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Timer Color")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                        
                        HStack {
                            
                            Text(timer.colorHex.uppercased())
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                
                RecipeTimerDetailFieldRow(
                    icon: "target",
                    title: "Accuracy Level",
                    value: timer.accuracyLevel,
                    color: .green
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct RecipeTimerDetailLimitsSection: View {
    let timer: RecipeTimer
    
    var body: some View {
        RecipeTimerDetailSectionView(
            title: "Duration Limits",
            icon: "slider.horizontal.3",
            color: .red
        ) {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                RecipeTimerDetailFieldRow(
                    icon: "minus.circle.fill",
                    title: "Minimum",
                    value: "\(timer.minDuration) min",
                    color: .red
                )
                
                RecipeTimerDetailFieldRow(
                    icon: "plus.circle.fill",
                    title: "Maximum",
                    value: "\(timer.maxDuration) min",
                    color: .red
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct RecipeTimerDetailStatusSection: View {
    let timer: RecipeTimer
    
    var body: some View {
        RecipeTimerDetailSectionView(
            title: "Status Information",
            icon: "info.circle.fill",
            color: .blue
        ) {
            VStack(spacing: 16) {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    RecipeTimerDetailToggleRow(
                        icon: "checkmark.circle.fill",
                        title: "Completed",
                        isEnabled: timer.completed,
                        color: .green
                    )
                    
                    RecipeTimerDetailToggleRow(
                        icon: "xmark.circle.fill",
                        title: "Cancelled",
                        isEnabled: timer.cancelled,
                        color: .red
                    )
                    
                    RecipeTimerDetailToggleRow(
                        icon: "pause.circle.fill",
                        title: "Paused",
                        isEnabled: timer.paused,
                        color: .yellow
                    )
                    
                    RecipeTimerDetailToggleRow(
                        icon: "play.circle.fill",
                        title: "Active",
                        isEnabled: timer.isActive,
                        color: .blue
                    )
                }
                
                if !timer.note.isEmpty {
                    RecipeTimerDetailNoteRow(
                        icon: "note.text",
                        title: "Notes",
                        content: timer.note,
                        color: .gray
                    )
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct RecipeTimerDetailMetadataSection: View {
    let timer: RecipeTimer
    
    var body: some View {
        RecipeTimerDetailSectionView(
            title: "System Information",
            icon: "gear",
            color: .gray
        ) {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                RecipeTimerDetailFieldRow(
                    icon: "iphone",
                    title: "Device ID",
                    value: timer.deviceID,
                    color: .gray
                )
                
                RecipeTimerDetailFieldRow(
                    icon: "person.fill",
                    title: "User ID",
                    value: timer.userID,
                    color: .gray
                )
                
                RecipeTimerDetailFieldRow(
                    icon: "icloud.fill",
                    title: "Backup Status",
                    value: timer.backupStatus,
                    color: .blue
                )
                
                RecipeTimerDetailFieldRow(
                    icon: "calendar",
                    title: "Created",
                    value: DateFormatter.shortDateTime.string(from: timer.createdAt),
                    color: .green
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct RecipeTimerDetailSectionView<Content: View>: View {
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
        VStack(spacing: 16) {
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
                    .frame(maxWidth: 100)
            }
            .padding(.horizontal)
            
            content
                .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

@available(iOS 14.0, *)
struct RecipeTimerDetailFieldRow: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundColor(color)
                    .frame(width: 20)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            Text(value)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

@available(iOS 14.0, *)
struct RecipeTimerDetailToggleRow: View {
    let icon: String
    let title: String
    let isEnabled: Bool
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundColor(color)
                    .frame(width: 20)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            HStack {
                Circle()
                    .fill(isEnabled ? color : Color.gray)
                    .frame(width: 12, height: 12)
                
                Text(isEnabled ? "Enabled" : "Disabled")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(isEnabled ? color : .secondary)
                
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

@available(iOS 14.0, *)
struct RecipeTimerDetailNoteRow: View {
    let icon: String
    let title: String
    let content: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundColor(color)
                    .frame(width: 20)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

