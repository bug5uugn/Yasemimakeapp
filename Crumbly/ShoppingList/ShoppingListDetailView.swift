import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListDetailView: View {
    let shoppingList: ShoppingList
    @ObservedObject var dataStore: RecipeDataStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Content Sections
                VStack(spacing: 24) {
                    // Basic Information Section
                    ShoppingListDetailSectionView(
                        title: "Basic Information",
                        icon: "info.circle.fill",
                        color: .blue
                    ) {
                        VStack(spacing: 16) {
                            ShoppingListDetailFieldRow(
                                label: "Title",
                                value: shoppingList.title,
                                icon: "text.cursor",
                                color: .blue
                            )
                            
                            ShoppingListDetailFieldRow(
                                label: "Owner",
                                value: shoppingList.owner,
                                icon: "person.fill",
                                color: .blue
                            )
                            
                            ShoppingListDetailFieldRow(
                                label: "Category",
                                value: shoppingList.category,
                                icon: "folder.fill",
                                color: .blue
                            )
                            
                            ShoppingListDetailFieldRow(
                                label: "List Type",
                                value: shoppingList.listType,
                                icon: "list.clipboard.fill",
                                color: .blue
                            )
                            
                            if !shoppingList.notes.isEmpty {
                                ShoppingListDetailFieldRow(
                                    label: "Notes",
                                    value: shoppingList.notes,
                                    icon: "note.text",
                                    color: .blue
                                )
                            }
                        }
                    }
                    
                    // Items Section
                    ShoppingListDetailSectionView(
                        title: "Shopping Items",
                        icon: "cart.fill",
                        color: .green
                    ) {
                        VStack(spacing: 12) {
                            // Progress Overview
                            ShoppingListDetailProgressView(shoppingList: shoppingList)
                            
                            // Items List
                            VStack(spacing: 8) {
                                ForEach(shoppingList.items, id: \.self) { item in
                                    ShoppingListDetailItemRow(
                                        item: item,
                                        isCompleted: shoppingList.completedItems.contains(item),
                                        color: Color(shoppingList.colorHex)
                                    )
                                }
                            }
                        }
                    }
                    
                    // Shopping Details Section
                    ShoppingListDetailSectionView(
                        title: "Shopping Details",
                        icon: "building.2.fill",
                        color: .orange
                    ) {
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                ShoppingListDetailFieldRow(
                                    label: "Store",
                                    value: shoppingList.store,
                                    icon: "building.2.fill",
                                    color: .orange
                                )
                                
                                ShoppingListDetailFieldRow(
                                    label: "Location",
                                    value: shoppingList.locationHint,
                                    icon: "location.fill",
                                    color: .orange
                                )
                            }
                            
                            HStack(spacing: 16) {
                                ShoppingListDetailFieldRow(
                                    label: "Estimated Cost",
                                    value: "\(shoppingList.currency) \(String(format: "%.2f", shoppingList.estimatedCost))",
                                    icon: "dollarsign.circle.fill",
                                    color: .orange
                                )
                                
                                ShoppingListDetailFieldRow(
                                    label: "Priority",
                                    value: "\(shoppingList.priority)/5",
                                    icon: "exclamationmark.triangle.fill",
                                    color: priorityColor(shoppingList.priority)
                                )
                            }
                            
                            if !shoppingList.aisleHints.isEmpty {
                                ShoppingListDetailFieldRow(
                                    label: "Aisle Hints",
                                    value: shoppingList.aisleHints.joined(separator: ", "),
                                    icon: "map.fill",
                                    color: .orange
                                )
                            }
                        }
                    }
                    
                    // Organization Section
                    ShoppingListDetailSectionView(
                        title: "Organization",
                        icon: "folder.badge.gearshape",
                        color: .purple
                    ) {
                        VStack(spacing: 16) {
                            if !shoppingList.tags.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Image(systemName: "tag.fill")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.purple)
                                        
                                        Text("Tags")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    
                                }
                            }
                            
                            HStack(spacing: 16) {
                                ShoppingListDetailFieldRow(
                                    label: "Color Theme",
                                    value: shoppingList.colorHex,
                                    icon: "paintpalette.fill",
                                    color: Color(shoppingList.colorHex)
                                )
                                
                                ShoppingListDetailFieldRow(
                                    label: "Icon",
                                    value: shoppingList.iconName,
                                    icon: shoppingList.iconName,
                                    color: .purple
                                )
                            }
                        }
                    }
                    
                    // Status & Settings Section
                    ShoppingListDetailSectionView(
                        title: "Status & Settings",
                        icon: "gearshape.fill",
                        color: .red
                    ) {
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                ShoppingListDetailStatusItem(
                                    label: "Shared",
                                    isActive: shoppingList.isShared,
                                    icon: "person.2.fill"
                                )
                                
                                ShoppingListDetailStatusItem(
                                    label: "Favorite",
                                    isActive: shoppingList.favorite,
                                    icon: "heart.fill"
                                )
                            }
                            
                            HStack(spacing: 16) {
                                ShoppingListDetailStatusItem(
                                    label: "Recurring",
                                    isActive: shoppingList.recurring,
                                    icon: "repeat"
                                )
                                
                                ShoppingListDetailStatusItem(
                                    label: "Archived",
                                    isActive: shoppingList.archived,
                                    icon: "archivebox.fill"
                                )
                            }
                            
                            if shoppingList.recurring && !shoppingList.recurrenceRule.isEmpty {
                                ShoppingListDetailFieldRow(
                                    label: "Recurrence Rule",
                                    value: shoppingList.recurrenceRule,
                                    icon: "calendar.badge.clock",
                                    color: .red
                                )
                            }
                        }
                    }
                    
                    // Technical Details Section
                    ShoppingListDetailSectionView(
                        title: "Technical Details",
                        icon: "gear",
                        color: .gray
                    ) {
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                ShoppingListDetailFieldRow(
                                    label: "Created",
                                    value: formatDate(shoppingList.createdAt),
                                    icon: "calendar.badge.plus",
                                    color: .gray
                                )
                                
                                ShoppingListDetailFieldRow(
                                    label: "Updated",
                                    value: formatDate(shoppingList.updatedAt),
                                    icon: "calendar.badge.clock",
                                    color: .gray
                                )
                            }
                            
                            HStack(spacing: 16) {
                                ShoppingListDetailFieldRow(
                                    label: "Last Used",
                                    value: formatDate(shoppingList.lastUsed),
                                    icon: "clock.fill",
                                    color: .gray
                                )
                                
                                ShoppingListDetailFieldRow(
                                    label: "Version",
                                    value: "\(shoppingList.version)",
                                    icon: "number",
                                    color: .gray
                                )
                            }
                            
                            HStack(spacing: 16) {
                                ShoppingListDetailFieldRow(
                                    label: "Device ID",
                                    value: shoppingList.deviceID,
                                    icon: "iphone",
                                    color: .gray
                                )
                                
                                ShoppingListDetailFieldRow(
                                    label: "Sync Status",
                                    value: shoppingList.syncStatus,
                                    icon: "arrow.triangle.2.circlepath",
                                    color: syncStatusColor(shoppingList.syncStatus)
                                )
                            }
                            
                            if !shoppingList.sharedWith.isEmpty {
                                ShoppingListDetailFieldRow(
                                    label: "Shared With",
                                    value: shoppingList.sharedWith.joined(separator: ", "),
                                    icon: "person.2.fill",
                                    color: .gray
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
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
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
