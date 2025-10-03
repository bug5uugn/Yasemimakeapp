import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListListRowView: View {
    let shoppingList: ShoppingList
    
    private var completionPercentage: Double {
        let total = shoppingList.items.count
        let completed = shoppingList.completedItems.count
        return total > 0 ? Double(completed) / Double(total) : 0.0
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Content Card
            VStack(spacing: 16) {
                // Header Row
                HStack(spacing: 12) {
                    // Icon and Color
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(shoppingList.colorHex).opacity(0.2))
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: shoppingList.iconName)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(Color(shoppingList.colorHex))
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(shoppingList.title)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        
                        HStack(spacing: 8) {
                            Text(shoppingList.category)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            Circle()
                                .fill(Color.secondary)
                                .frame(width: 3, height: 3)
                            
                            Text(shoppingList.store)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        if shoppingList.favorite {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.red)
                        }
                        
                        Text("\(shoppingList.currency) \(String(format: "%.2f", shoppingList.estimatedCost))")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(shoppingList.colorHex))
                    }
                }
                
                // Progress Bar
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Progress")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("\(shoppingList.completedItems.count)/\(shoppingList.items.count) items")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(.systemGray5))
                                .frame(height: 8)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(shoppingList.colorHex))
                                .frame(width: geometry.size.width * completionPercentage, height: 8)
                                .animation(.easeInOut(duration: 0.3), value: completionPercentage)
                        }
                    }
                    .frame(height: 8)
                }
                
                // Details Grid
                VStack(spacing: 12) {
                    HStack(spacing: 16) {
                        ShoppingListRowDetailItem(
                            icon: "person.fill",
                            title: "Owner",
                            value: shoppingList.owner,
                            color: .blue
                        )
                        
                        Spacer()
                        
                        ShoppingListRowDetailItem(
                            icon: "exclamationmark.triangle.fill",
                            title: "Priority",
                            value: "\(shoppingList.priority)",
                            color: priorityColor(shoppingList.priority)
                        )
                    }
                    
                    HStack(spacing: 16) {
                        ShoppingListRowDetailItem(
                            icon: "location.fill",
                            title: "Location",
                            value: shoppingList.locationHint,
                            color: .green
                        )
                        
                        Spacer()
                        
                        ShoppingListRowDetailItem(
                            icon: "calendar",
                            title: "Updated",
                            value: formatDate(shoppingList.updatedAt),
                            color: .orange
                        )
                    }
                }
                
                // Tags and Status
                VStack(spacing: 8) {
                    if !shoppingList.tags.isEmpty {
                        HStack {
                            Text("Tags:")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 6) {
                                    ForEach(shoppingList.tags.prefix(3), id: \.self) { tag in
                                        Text(tag)
                                            .font(.system(size: 11, weight: .medium))
                                            .foregroundColor(Color(hex: shoppingList.colorHex))
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(
                                                Capsule()
                                                    .fill(Color(hex: shoppingList.colorHex).opacity(0.1))
                                            )
                                    }
                                    
                                    if shoppingList.tags.count > 3 {
                                        Text("+\(shoppingList.tags.count - 3)")
                                            .font(.system(size: 11, weight: .medium))
                                            .foregroundColor(.secondary)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(
                                                Capsule()
                                                    .fill(Color(.systemGray5))
                                            )
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack(spacing: 12) {
                        if shoppingList.isShared {
                            Label("Shared", systemImage: "person.2.fill")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.blue)
                        }
                        
                        if shoppingList.recurring {
                            Label("Recurring", systemImage: "repeat")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.purple)
                        }
                        
                        Spacer()
                        
                        Text(shoppingList.syncStatus)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(syncStatusColor(shoppingList.syncStatus))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(
                                Capsule()
                                    .fill(syncStatusColor(shoppingList.syncStatus).opacity(0.1))
                            )
                    }
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            )
        }
    }
    
    private func priorityColor(_ priority: Int) -> Color {
        switch priority {
        case 1: return .green
        case 2: return .yellow
        case 3: return .orange
        case 4: return .red
        case 5: return .purple
        default: return .gray
        }
    }
    
    private func syncStatusColor(_ status: String) -> Color {
        switch status.lowercased() {
        case "synced": return .green
        case "pending": return .orange
        case "local": return .blue
        default: return .gray
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
