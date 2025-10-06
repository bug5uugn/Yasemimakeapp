import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var dataStore: RecipeDataStore
    
    @State private var title = ""
    @State private var itemsText = ""
    @State private var owner = ""
    @State private var tagsText = ""
    @State private var notes = ""
    @State private var estimatedCost = ""
    @State private var currency = "USD"
    @State private var priority = 1
    @State private var category = ""
    @State private var store = ""
    @State private var aisleHintsText = ""
    @State private var colorHex = "#4CAF50"
    @State private var iconName = "cart.fill"
    @State private var locationHint = ""
    @State private var listType = "Grocery"
    @State private var isShared = false
    @State private var favorite = false
    @State private var recurring = false
    @State private var recurrenceRule = ""
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    private let currencies = ["USD", "EUR", "GBP", "CAD", "AUD"]
    private let listTypes = ["Grocery", "Party", "Hardware", "Personal", "Work"]
    private let colors = ["#4CAF50", "#FF9800", "#2196F3", "#9C27B0", "#F44336", "#FF5722"]
    private let icons = ["cart.fill", "gift.fill", "hammer.fill", "person.fill", "briefcase.fill"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Header Section
                    ShoppingListAddHeaderView()
                    
                    // Form Content
                    VStack(spacing: 24) {
                        // Basic Information Section
                        ShoppingListAddSectionHeaderView(
                            title: "Basic Information",
                            icon: "info.circle.fill",
                            color: Color.blue
                        )
                        
                        VStack(spacing: 16) {
                            ShoppingListAddFieldView(
                                title: "List Title",
                                text: $title,
                                icon: "text.cursor",
                                placeholder: "Enter list title"
                            )
                            
                            ShoppingListAddFieldView(
                                title: "Owner",
                                text: $owner,
                                icon: "person.fill",
                                placeholder: "List owner name"
                            )
                            
                            ShoppingListAddTextAreaView(
                                title: "Items",
                                text: $itemsText,
                                icon: "list.bullet",
                                placeholder: "Enter items separated by commas"
                            )
                            
                            ShoppingListAddFieldView(
                                title: "Category",
                                text: $category,
                                icon: "folder.fill",
                                placeholder: "e.g., Groceries, Party"
                            )
                        }
                        
                        // Shopping Details Section
                        ShoppingListAddSectionHeaderView(
                            title: "Shopping Details",
                            icon: "cart.fill",
                            color: Color.green
                        )
                        
                        VStack(spacing: 16) {
                            ShoppingListAddFieldView(
                                title: "Store",
                                text: $store,
                                icon: "building.2.fill",
                                placeholder: "Store name"
                            )
                            
                            ShoppingListAddFieldView(
                                title: "Location Hint",
                                text: $locationHint,
                                icon: "location.fill",
                                placeholder: "Store location or address"
                            )
                            
                            HStack(spacing: 16) {
                                ShoppingListAddFieldView(
                                    title: "Estimated Cost",
                                    text: $estimatedCost,
                                    icon: "dollarsign.circle.fill",
                                    placeholder: "0.00"
                                )
                                
                                ShoppingListAddPickerView(
                                    title: "Currency",
                                    selection: $currency,
                                    options: currencies,
                                    icon: "creditcard.fill"
                                )
                            }
                            
                            ShoppingListAddTextAreaView(
                                title: "Aisle Hints",
                                text: $aisleHintsText,
                                icon: "map.fill",
                                placeholder: "Enter aisle hints separated by commas"
                            )
                        }
                        
                        // Organization Section
                        ShoppingListAddSectionHeaderView(
                            title: "Organization",
                            icon: "folder.badge.gearshape",
                            color: Color.purple
                        )
                        
                        VStack(spacing: 16) {
                            ShoppingListAddFieldView(
                                title: "Tags",
                                text: $tagsText,
                                icon: "tag.fill",
                                placeholder: "Enter tags separated by commas"
                            )
                            
                            ShoppingListAddSliderView(
                                title: "Priority",
                                value: $priority,
                                range: 1...5,
                                icon: "exclamationmark.triangle.fill"
                            )
                            
                            HStack(spacing: 16) {
                                ShoppingListAddPickerView(
                                    title: "List Type",
                                    selection: $listType,
                                    options: listTypes,
                                    icon: "list.clipboard.fill"
                                )
                                
                                ShoppingListAddPickerView(
                                    title: "Icon",
                                    selection: $iconName,
                                    options: icons,
                                    icon: "star.fill"
                                )
                            }
                            
                            ShoppingListAddColorPickerView(
                                title: "Color Theme",
                                selection: $colorHex,
                                colors: colors
                            )
                        }
                        
                        // Settings Section
                        ShoppingListAddSectionHeaderView(
                            title: "Settings",
                            icon: "gearshape.fill",
                            color: Color.orange
                        )
                        
                        VStack(spacing: 16) {
                            ShoppingListAddToggleView(
                                title: "Shared List",
                                isOn: $isShared,
                                icon: "person.2.fill"
                            )
                            
                            ShoppingListAddToggleView(
                                title: "Favorite",
                                isOn: $favorite,
                                icon: "heart.fill"
                            )
                            
                            ShoppingListAddToggleView(
                                title: "Recurring",
                                isOn: $recurring,
                                icon: "repeat"
                            )
                            
                            if recurring {
                                ShoppingListAddFieldView(
                                    title: "Recurrence Rule",
                                    text: $recurrenceRule,
                                    icon: "calendar.badge.clock",
                                    placeholder: "e.g., Weekly, Monthly"
                                )
                            }
                            
                            ShoppingListAddTextAreaView(
                                title: "Notes",
                                text: $notes,
                                icon: "note.text",
                                placeholder: "Additional notes or reminders"
                            )
                        }
                        
                        // Save Button
                        ShoppingListAddSaveButtonView(action: saveShoppingList)
                            .padding(.top, 32)
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
            .navigationBarHidden(true)
        }
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
    
    private func saveShoppingList() {
        var errors: [String] = []
        
        // Validation
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Title is required")
        }
        if owner.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Owner is required")
        }
        if itemsText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Items are required")
        }
        if category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Category is required")
        }
        if store.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Store is required")
        }
        if estimatedCost.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Estimated cost is required")
        } else if Double(estimatedCost) == nil {
            errors.append("• Estimated cost must be a valid number")
        }
        if locationHint.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Location hint is required")
        }
        if tagsText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• At least one tag is required")
        }
        if aisleHintsText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Aisle hints are required")
        }
        if recurring && recurrenceRule.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Recurrence rule is required when recurring is enabled")
        }
        
        if !errors.isEmpty {
            alertTitle = "Validation Errors"
            alertMessage = "Please fix the following issues:\n\n" + errors.joined(separator: "\n")
            showAlert = true
            return
        }
        
        // Create shopping list
        let items = itemsText.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
        let tags = tagsText.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
        let aisleHints = aisleHintsText.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
        
        let newList = ShoppingList(
            title: title,
            items: items,
            createdAt: Date(),
            updatedAt: Date(),
            owner: owner,
            isShared: isShared,
            tags: tags,
            notes: notes,
            estimatedCost: Double(estimatedCost) ?? 0.0,
            currency: currency,
            priority: priority,
            reminders: [],
            completedItems: [],
            pendingItems: items,
            category: category,
            store: store,
            aisleHints: aisleHints,
            favorite: favorite,
            archived: false,
            recurring: recurring,
            recurrenceRule: recurring ? recurrenceRule : "",
            lastUsed: Date(),
            colorHex: colorHex,
            iconName: iconName,
            sharedWith: [],
            exported: false,
            imported: false,
            deviceID: "iOS_Device",
            backupFile: "",
            syncStatus: "Local",
            locationHint: locationHint,
            listType: listType,
            version: 1,
            draft: false
        )
        
        dataStore.addShoppingList(newList)
        
        alertTitle = "Success"
        alertMessage = "Shopping list '\(title)' has been created successfully!"
        showAlert = true
    }
}
