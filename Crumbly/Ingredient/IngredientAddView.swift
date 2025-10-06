import SwiftUI

@available(iOS 14.0, *)
struct IngredientAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var store: RecipeDataStore
    
    @State private var name = ""
    @State private var amount = ""
    @State private var unit = ""
    @State private var notes = ""
    @State private var category = ""
    @State private var isOptional = false
    @State private var allergens: [String] = []
    @State private var calories = ""
    @State private var protein = ""
    @State private var carbs = ""
    @State private var fat = ""
    @State private var fiber = ""
    @State private var sugar = ""
    @State private var sodium = ""
    @State private var source = ""
    @State private var brand = ""
    @State private var cost = ""
    @State private var isAvailable = true
    @State private var purchaseDate = Date()
    @State private var expiryDate = Date()
    @State private var storageLocation = ""
    @State private var substituteOptions: [String] = []
    @State private var color = ""
    @State private var texture = ""
    @State private var origin = ""
    @State private var organic = false
    @State private var glutenFree = false
    @State private var vegan = false
    @State private var vegetarian = false
    @State private var halal = false
    @State private var kosher = false
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isSuccess = false
    
    let categories = ["Vegetables", "Fruits", "Grains", "Proteins", "Dairy", "Oils & Fats", "Spices", "Herbs", "Nuts", "Seeds"]
    let units = ["pieces", "cups", "tablespoons", "teaspoons", "ounces", "pounds", "grams", "kilograms", "liters", "milliliters"]
    let storageLocations = ["Refrigerator", "Freezer", "Pantry", "Counter", "Spice Rack", "Wine Cellar"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    IngredientAddHeaderView()
                    
                    LazyVStack(spacing: 20) {
                        IngredientAddBasicInfoSection(
                            name: $name,
                            amount: $amount,
                            unit: $unit,
                            category: $category,
                            units: units,
                            categories: categories
                        )
                        
                        IngredientAddNutritionSection(
                            calories: $calories,
                            protein: $protein,
                            carbs: $carbs,
                            fat: $fat,
                            fiber: $fiber,
                            sugar: $sugar,
                            sodium: $sodium
                        )
                        
                        IngredientAddDetailsSection(
                            notes: $notes,
                            source: $source,
                            brand: $brand,
                            cost: $cost,
                            color: $color,
                            texture: $texture,
                            origin: $origin
                        )
                        
                        IngredientAddStorageSection(
                            purchaseDate: $purchaseDate,
                            expiryDate: $expiryDate,
                            storageLocation: $storageLocation,
                            storageLocations: storageLocations,
                            isAvailable: $isAvailable
                        )
                        
                        IngredientAddDietarySection(
                            organic: $organic,
                            glutenFree: $glutenFree,
                            vegan: $vegan,
                            vegetarian: $vegetarian,
                            halal: $halal,
                            kosher: $kosher,
                            isOptional: $isOptional
                        )
                        
                        IngredientAddActionButton(action: saveIngredient)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.orange),
                trailing: EmptyView()
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
    
    private func saveIngredient() {
        let validationErrors = validateFields()
        
        if !validationErrors.isEmpty {
            alertMessage = validationErrors.joined(separator: "\n")
            isSuccess = false
            showingAlert = true
            return
        }
        
        let newIngredient = Ingredient(
            name: name,
            amount: amount,
            unit: unit,
            notes: notes,
            category: category,
            isOptional: isOptional,
            allergens: allergens,
            calories: Int(calories) ?? 0,
            protein: Int(protein) ?? 0,
            carbs: Int(carbs) ?? 0,
            fat: Int(fat) ?? 0,
            fiber: Int(fiber) ?? 0,
            sugar: Int(sugar) ?? 0,
            sodium: Int(sodium) ?? 0,
            source: source,
            brand: brand,
            cost: Double(cost) ?? 0.0,
            isAvailable: isAvailable,
            purchaseDate: purchaseDate,
            expiryDate: expiryDate,
            storageLocation: storageLocation,
            substituteOptions: substituteOptions,
            color: color,
            texture: texture,
            origin: origin,
            organic: organic,
            glutenFree: glutenFree,
            vegan: vegan,
            vegetarian: vegetarian,
            halal: halal,
            kosher: kosher,
            addedAt: Date(),
            updatedAt: Date()
        )
        
        store.addIngredient(newIngredient)
        
        alertMessage = "Ingredient '\(name)' has been successfully added to your collection!"
        isSuccess = true
        showingAlert = true
    }
    
    private func validateFields() -> [String] {
        var errors: [String] = []
        
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Name is required")
        }
        if amount.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Amount is required")
        }
        if unit.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Unit is required")
        }
        if category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Category is required")
        }
        if source.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Source is required")
        }
        if brand.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Brand is required")
        }
        if cost.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Cost is required")
        } else if Double(cost) == nil {
            errors.append("• Cost must be a valid number")
        }
        if storageLocation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Storage location is required")
        }
        if color.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Color is required")
        }
        if texture.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Texture is required")
        }
        if origin.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Origin is required")
        }
        if !calories.isEmpty && Int(calories) == nil {
            errors.append("• Calories must be a valid number")
        }
        if !protein.isEmpty && Int(protein) == nil {
            errors.append("• Protein must be a valid number")
        }
        if !carbs.isEmpty && Int(carbs) == nil {
            errors.append("• Carbs must be a valid number")
        }
        if !fat.isEmpty && Int(fat) == nil {
            errors.append("• Fat must be a valid number")
        }
        if expiryDate < purchaseDate {
            errors.append("• Expiry date must be after purchase date")
        }
        
        return errors
    }
}

@available(iOS 14.0, *)
struct IngredientAddHeaderView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 50))
                .foregroundColor(.green)
                .padding(.top, 20)
            
            Text("Add New Ingredient")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Fill in the details below to add a new ingredient to your collection")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .padding(.bottom, 30)
        .background(Color(.systemBackground))
    }
}

@available(iOS 14.0, *)
struct IngredientAddBasicInfoSection: View {
    @Binding var name: String
    @Binding var amount: String
    @Binding var unit: String
    @Binding var category: String
    let units: [String]
    let categories: [String]
    
    var body: some View {
        IngredientAddSectionContainer(
            title: "Basic Information",
            icon: "info.circle.fill",
            color: .blue
        ) {
            VStack(spacing: 15) {
                IngredientAddFloatingField(
                    title: "Ingredient Name",
                    text: $name,
                    icon: "textformat",
                    placeholder: "e.g., Organic Tomatoes"
                )
                
                HStack(spacing: 15) {
                    IngredientAddFloatingField(
                        title: "Amount",
                        text: $amount,
                        icon: "number",
                        placeholder: "e.g., 2"
                    )
                    
                    IngredientAddPickerField(
                        title: "Unit",
                        selection: $unit,
                        options: units,
                        icon: "ruler"
                    )
                }
                
                IngredientAddPickerField(
                    title: "Category",
                    selection: $category,
                    options: categories,
                    icon: "folder.fill"
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientAddNutritionSection: View {
    @Binding var calories: String
    @Binding var protein: String
    @Binding var carbs: String
    @Binding var fat: String
    @Binding var fiber: String
    @Binding var sugar: String
    @Binding var sodium: String
    
    var body: some View {
        IngredientAddSectionContainer(
            title: "Nutrition Facts",
            icon: "heart.fill",
            color: .red
        ) {
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    IngredientAddFloatingField(
                        title: "Calories",
                        text: $calories,
                        icon: "flame.fill",
                        placeholder: "0",
                        keyboardType: .numberPad
                    )
                    
                    IngredientAddFloatingField(
                        title: "Protein (g)",
                        text: $protein,
                        icon: "p.circle.fill",
                        placeholder: "0",
                        keyboardType: .numberPad
                    )
                }
                
                HStack(spacing: 15) {
                    IngredientAddFloatingField(
                        title: "Carbs (g)",
                        text: $carbs,
                        icon: "c.circle.fill",
                        placeholder: "0",
                        keyboardType: .numberPad
                    )
                    
                    IngredientAddFloatingField(
                        title: "Fat (g)",
                        text: $fat,
                        icon: "f.circle.fill",
                        placeholder: "0",
                        keyboardType: .numberPad
                    )
                }
                
                HStack(spacing: 15) {
                    IngredientAddFloatingField(
                        title: "Fiber (g)",
                        text: $fiber,
                        icon: "leaf.circle.fill",
                        placeholder: "0",
                        keyboardType: .numberPad
                    )
                    
                    IngredientAddFloatingField(
                        title: "Sugar (g)",
                        text: $sugar,
                        icon: "s.circle.fill",
                        placeholder: "0",
                        keyboardType: .numberPad
                    )
                }
                
                IngredientAddFloatingField(
                    title: "Sodium (mg)",
                    text: $sodium,
                    icon: "drop.fill",
                    placeholder: "0",
                    keyboardType: .numberPad
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientAddDetailsSection: View {
    @Binding var notes: String
    @Binding var source: String
    @Binding var brand: String
    @Binding var cost: String
    @Binding var color: String
    @Binding var texture: String
    @Binding var origin: String
    
    var body: some View {
        IngredientAddSectionContainer(
            title: "Details & Properties",
            icon: "doc.text.fill",
            color: .purple
        ) {
            VStack(spacing: 15) {
                IngredientAddFloatingField(
                    title: "Notes",
                    text: $notes,
                    icon: "note.text",
                    placeholder: "Additional notes about this ingredient"
                )
                
                HStack(spacing: 15) {
                    IngredientAddFloatingField(
                        title: "Source",
                        text: $source,
                        icon: "location.fill",
                        placeholder: "e.g., Local Farm"
                    )
                    
                    IngredientAddFloatingField(
                        title: "Brand",
                        text: $brand,
                        icon: "tag.fill",
                        placeholder: "e.g., Organic Valley"
                    )
                }
                
                IngredientAddFloatingField(
                    title: "Cost ($)",
                    text: $cost,
                    icon: "dollarsign.circle.fill",
                    placeholder: "0.00",
                    keyboardType: .decimalPad
                )
                
                HStack(spacing: 15) {
                    IngredientAddFloatingField(
                        title: "Color",
                        text: $color,
                        icon: "paintpalette.fill",
                        placeholder: "e.g., Red"
                    )
                    
                    IngredientAddFloatingField(
                        title: "Texture",
                        text: $texture,
                        icon: "hand.point.up.fill",
                        placeholder: "e.g., Firm"
                    )
                }
                
                IngredientAddFloatingField(
                    title: "Origin",
                    text: $origin,
                    icon: "globe",
                    placeholder: "e.g., California, USA"
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientAddStorageSection: View {
    @Binding var purchaseDate: Date
    @Binding var expiryDate: Date
    @Binding var storageLocation: String
    let storageLocations: [String]
    @Binding var isAvailable: Bool
    
    var body: some View {
        IngredientAddSectionContainer(
            title: "Storage & Availability",
            icon: "archivebox.fill",
            color: .orange
        ) {
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    IngredientAddDatePickerField(
                        title: "Purchase Date",
                        date: $purchaseDate,
                        icon: "calendar.badge.plus"
                    )
                    
                    IngredientAddDatePickerField(
                        title: "Expiry Date",
                        date: $expiryDate,
                        icon: "calendar.badge.exclamationmark"
                    )
                }
                
                IngredientAddPickerField(
                    title: "Storage Location",
                    selection: $storageLocation,
                    options: storageLocations,
                    icon: "house.fill"
                )
                
                IngredientAddToggleField(
                    title: "Currently Available",
                    isOn: $isAvailable,
                    icon: "checkmark.circle.fill"
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientAddDietarySection: View {
    @Binding var organic: Bool
    @Binding var glutenFree: Bool
    @Binding var vegan: Bool
    @Binding var vegetarian: Bool
    @Binding var halal: Bool
    @Binding var kosher: Bool
    @Binding var isOptional: Bool
    
    var body: some View {
        IngredientAddSectionContainer(
            title: "Dietary Information",
            icon: "leaf.arrow.circlepath",
            color: .green
        ) {
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    IngredientAddToggleField(
                        title: "Organic",
                        isOn: $organic,
                        icon: "leaf.fill"
                    )
                    
                    IngredientAddToggleField(
                        title: "Gluten Free",
                        isOn: $glutenFree,
                        icon: "g.circle.fill"
                    )
                }
                
                HStack(spacing: 15) {
                    IngredientAddToggleField(
                        title: "Vegan",
                        isOn: $vegan,
                        icon: "v.circle.fill"
                    )
                    
                    IngredientAddToggleField(
                        title: "Vegetarian",
                        isOn: $vegetarian,
                        icon: "carrot.fill"
                    )
                }
                
                HStack(spacing: 15) {
                    IngredientAddToggleField(
                        title: "Halal",
                        isOn: $halal,
                        icon: "h.circle.fill"
                    )
                    
                    IngredientAddToggleField(
                        title: "Kosher",
                        isOn: $kosher,
                        icon: "k.circle.fill"
                    )
                }
                
                IngredientAddToggleField(
                    title: "Optional Ingredient",
                    isOn: $isOptional,
                    icon: "questionmark.circle.fill"
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientAddSectionContainer<Content: View>: View {
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
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title2)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            content
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

@available(iOS 14.0, *)
struct IngredientAddFloatingField: View {
    let title: String
    @Binding var text: String
    let icon: String
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.secondary)
                    .font(.caption)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
            
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(text.isEmpty ? Color.clear : Color.blue, lineWidth: 1)
                )
        }
    }
}

@available(iOS 14.0, *)
struct IngredientAddPickerField: View {
    let title: String
    @Binding var selection: String
    let options: [String]
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.secondary)
                    .font(.caption)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
            
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(option) {
                        selection = option
                    }
                }
            } label: {
                HStack {
                    Text(selection.isEmpty ? "Select \(title)" : selection)
                        .foregroundColor(selection.isEmpty ? .secondary : .primary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientAddDatePickerField: View {
    let title: String
    @Binding var date: Date
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.secondary)
                    .font(.caption)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
    }
}

@available(iOS 14.0, *)
struct IngredientAddToggleField: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(isOn ? .green : .secondary)
                .font(.title3)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .green))
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

@available(iOS 14.0, *)
struct IngredientAddActionButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                
                Text("Add Ingredient")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.green, .blue]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(15)
            .shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 5)
        }
        .padding(.top, 20)
    }
}
