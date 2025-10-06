import SwiftUI

@available(iOS 14.0, *)
struct IngredientDetailView: View {
    let ingredient: Ingredient
    let store: RecipeDataStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    IngredientDetailHeaderView(ingredient: ingredient)
                    
                    LazyVStack(spacing: 20) {
                        IngredientDetailOverviewCard(ingredient: ingredient)
                        IngredientDetailNutritionCard(ingredient: ingredient)
                        IngredientDetailPropertiesCard(ingredient: ingredient)
                        IngredientDetailStorageCard(ingredient: ingredient)
                        IngredientDetailDietaryCard(ingredient: ingredient)
                        IngredientDetailMetadataCard(ingredient: ingredient)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemGray6), Color(.systemBackground)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.orange)
            )
        }
    }
}

@available(iOS 14.0, *)
struct IngredientDetailHeaderView: View {
    let ingredient: Ingredient
    
    var categoryColor: Color {
        switch ingredient.category.lowercased() {
        case "vegetables": return .green
        case "fruits": return .orange
        case "grains": return .yellow
        case "proteins": return .red
        case "dairy": return .blue
        case "oils & fats": return .purple
        case "spices": return .orange
        case "herbs": return .yellow
        default: return .gray
        }
    }
    
    var categoryIcon: String {
        switch ingredient.category.lowercased() {
        case "vegetables": return "carrot.fill"
        case "fruits": return "apple.logo"
        case "grains": return "leaf.fill"
        case "proteins": return "fish.fill"
        case "dairy": return "drop.fill"
        case "oils & fats": return "drop.circle.fill"
        case "spices": return "sparkles"
        case "herbs": return "leaf.arrow.circlepath"
        default: return "circle.fill"
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: categoryIcon)
                .font(.system(size: 80))
                .foregroundColor(.white)
                .frame(width: 120, height: 120)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [categoryColor, categoryColor.opacity(0.7)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(30)
                .shadow(color: categoryColor.opacity(0.4), radius: 15, x: 0, y: 8)
            
            VStack(spacing: 8) {
                Text(ingredient.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Text("\(ingredient.amount) \(ingredient.unit)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 15) {
                    IngredientDetailHeaderBadge(
                        text: ingredient.category,
                        color: categoryColor,
                        icon: "folder.fill"
                    )
                    
                    IngredientDetailHeaderBadge(
                        text: String(format: "$%.2f", ingredient.cost),
                        color: .green,
                        icon: "dollarsign.circle.fill"
                    )

                    IngredientDetailHeaderBadge(
                        text: ingredient.isAvailable ? "Available" : "Out of Stock",
                        color: ingredient.isAvailable ? .green : .red,
                        icon: ingredient.isAvailable ? "checkmark.circle.fill" : "xmark.circle.fill"
                    )
                }
            }
        }
        .padding(.vertical, 30)
        .background(Color(.systemBackground))
    }
}

@available(iOS 14.0, *)
struct IngredientDetailHeaderBadge: View {
    let text: String
    let color: Color
    let icon: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .font(.caption)
            
            Text(text)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(color)
        .cornerRadius(15)
    }
}

@available(iOS 14.0, *)
struct IngredientDetailOverviewCard: View {
    let ingredient: Ingredient
    
    var body: some View {
        IngredientDetailCardContainer(
            title: "Overview",
            icon: "info.circle.fill",
            color: .blue
        ) {
            VStack(spacing: 15) {
                IngredientDetailTwoColumnRow(
                    leftTitle: "Brand",
                    leftValue: ingredient.brand,
                    leftIcon: "tag.fill",
                    rightTitle: "Source",
                    rightValue: ingredient.source,
                    rightIcon: "location.fill"
                )
                
                IngredientDetailTwoColumnRow(
                    leftTitle: "Origin",
                    leftValue: ingredient.origin,
                    leftIcon: "globe",
                    rightTitle: "Color",
                    rightValue: ingredient.color,
                    rightIcon: "paintpalette.fill"
                )
                
                IngredientDetailSingleRow(
                    title: "Texture",
                    value: ingredient.texture,
                    icon: "hand.point.up.fill"
                )
                
                if !ingredient.notes.isEmpty {
                    IngredientDetailSingleRow(
                        title: "Notes",
                        value: ingredient.notes,
                        icon: "note.text"
                    )
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientDetailNutritionCard: View {
    let ingredient: Ingredient
    
    var body: some View {
        IngredientDetailCardContainer(
            title: "Nutrition Facts",
            icon: "heart.fill",
            color: .red
        ) {
            VStack(spacing: 15) {
                IngredientDetailNutritionGrid(ingredient: ingredient)
                
                if !ingredient.allergens.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                                .font(.caption)
                            
                            Text("Allergens")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(ingredient.allergens, id: \.self) { allergen in
                                    Text(allergen)
                                        .font(.caption2)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Color.orange)
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientDetailNutritionGrid: View {
    let ingredient: Ingredient
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 15) {
            IngredientDetailNutritionItem(
                title: "Calories",
                value: "\(ingredient.calories)",
                unit: "cal",
                color: .orange,
                icon: "flame.fill"
            )
            
            IngredientDetailNutritionItem(
                title: "Protein",
                value: "\(ingredient.protein)",
                unit: "g",
                color: .red,
                icon: "p.circle.fill"
            )
            
            IngredientDetailNutritionItem(
                title: "Carbs",
                value: "\(ingredient.carbs)",
                unit: "g",
                color: .blue,
                icon: "c.circle.fill"
            )
            
            IngredientDetailNutritionItem(
                title: "Fat",
                value: "\(ingredient.fat)",
                unit: "g",
                color: .purple,
                icon: "f.circle.fill"
            )
            
            IngredientDetailNutritionItem(
                title: "Fiber",
                value: "\(ingredient.fiber)",
                unit: "g",
                color: .green,
                icon: "leaf.circle.fill"
            )
            
            IngredientDetailNutritionItem(
                title: "Sugar",
                value: "\(ingredient.sugar)",
                unit: "g",
                color: .pink,
                icon: "s.circle.fill"
            )
        }
        
        IngredientDetailSingleRow(
            title: "Sodium",
            value: "\(ingredient.sodium) mg",
            icon: "drop.fill"
        )
    }
}

@available(iOS 14.0, *)
struct IngredientDetailNutritionItem: View {
    let title: String
    let value: String
    let unit: String
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(unit)
                .font(.caption2)
                .foregroundColor(.secondary)
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

@available(iOS 14.0, *)
struct IngredientDetailPropertiesCard: View {
    let ingredient: Ingredient
    
    var body: some View {
        IngredientDetailCardContainer(
            title: "Properties",
            icon: "doc.text.fill",
            color: .purple
        ) {
            VStack(spacing: 15) {
                IngredientDetailTwoColumnRow(
                    leftTitle: "Optional",
                    leftValue: ingredient.isOptional ? "Yes" : "No",
                    leftIcon: "questionmark.circle.fill",
                    rightTitle: "Available",
                    rightValue: ingredient.isAvailable ? "Yes" : "No",
                    rightIcon: ingredient.isAvailable ? "checkmark.circle.fill" : "xmark.circle.fill"
                )
                
                if !ingredient.substituteOptions.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .foregroundColor(.blue)
                                .font(.caption)
                            
                            Text("Substitute Options")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(ingredient.substituteOptions, id: \.self) { substitute in
                                    Text(substitute)
                                        .font(.caption2)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Color.blue)
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientDetailStorageCard: View {
    let ingredient: Ingredient
    
    var body: some View {
        IngredientDetailCardContainer(
            title: "Storage & Dates",
            icon: "archivebox.fill",
            color: .orange
        ) {
            VStack(spacing: 15) {
                IngredientDetailSingleRow(
                    title: "Storage Location",
                    value: ingredient.storageLocation,
                    icon: "house.fill"
                )
                
                IngredientDetailTwoColumnRow(
                    leftTitle: "Purchase Date",
                    leftValue: DateFormatter.shortDate.string(from: ingredient.purchaseDate),
                    leftIcon: "calendar.badge.plus",
                    rightTitle: "Expiry Date",
                    rightValue: DateFormatter.shortDate.string(from: ingredient.expiryDate),
                    rightIcon: "calendar.badge.exclamationmark"
                )
                
                let daysUntilExpiry = Calendar.current.dateComponents([.day], from: Date(), to: ingredient.expiryDate).day ?? 0
                
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(daysUntilExpiry < 0 ? .red : daysUntilExpiry < 7 ? .orange : .green)
                        .font(.caption)
                    
                    Text("Freshness Status")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(daysUntilExpiry < 0 ? "Expired" : daysUntilExpiry == 0 ? "Expires Today" : "\(daysUntilExpiry) days left")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(daysUntilExpiry < 0 ? .red : daysUntilExpiry < 7 ? .orange : .green)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientDetailDietaryCard: View {
    let ingredient: Ingredient
    
    var dietaryInfo: [(String, Bool, String, Color)] {
        [
            ("Organic", ingredient.organic, "leaf.fill", .green),
            ("Gluten Free", ingredient.glutenFree, "g.circle.fill", .orange),
            ("Vegan", ingredient.vegan, "v.circle.fill", .green),
            ("Vegetarian", ingredient.vegetarian, "carrot.fill", .orange),
            ("Halal", ingredient.halal, "h.circle.fill", .blue),
            ("Kosher", ingredient.kosher, "k.circle.fill", .purple)
        ]
    }
    
    var body: some View {
        IngredientDetailCardContainer(
            title: "Dietary Information",
            icon: "leaf.arrow.circlepath",
            color: .green
        ) {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 15) {
                ForEach(dietaryInfo, id: \.0) { info in
                    IngredientDetailDietaryItem(
                        title: info.0,
                        isTrue: info.1,
                        icon: info.2,
                        color: info.3
                    )
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientDetailDietaryItem: View {
    let title: String
    let isTrue: Bool
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(isTrue ? color : .secondary)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(isTrue ? "Yes" : "No")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(isTrue ? color : .secondary)
            }
            
            Spacer()
            
            Image(systemName: isTrue ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.caption)
                .foregroundColor(isTrue ? color : .secondary)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(isTrue ? color.opacity(0.1) : Color(.systemGray6))
        .cornerRadius(10)
    }
}

@available(iOS 14.0, *)
struct IngredientDetailMetadataCard: View {
    let ingredient: Ingredient
    
    var body: some View {
        IngredientDetailCardContainer(
            title: "Metadata",
            icon: "info.circle.fill",
            color: .gray
        ) {
            VStack(spacing: 15) {
                IngredientDetailTwoColumnRow(
                    leftTitle: "Added",
                    leftValue: DateFormatter.shortDateTime.string(from: ingredient.addedAt),
                    leftIcon: "calendar.badge.plus",
                    rightTitle: "Updated",
                    rightValue: DateFormatter.shortDateTime.string(from: ingredient.updatedAt),
                    rightIcon: "calendar.badge.clock"
                )
                
                IngredientDetailSingleRow(
                    title: "Ingredient ID",
                    value: ingredient.id.uuidString.prefix(8).uppercased(),
                    icon: "number.circle.fill"
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientDetailCardContainer<Content: View>: View {
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
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title2)
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            content
        }
        .padding(25)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

@available(iOS 14.0, *)
struct IngredientDetailTwoColumnRow: View {
    let leftTitle: String
    let leftValue: String
    let leftIcon: String
    let rightTitle: String
    let rightValue: String
    let rightIcon: String
    
    var body: some View {
        HStack(spacing: 15) {
            IngredientDetailFieldRow(
                title: leftTitle,
                value: leftValue,
                icon: leftIcon
            )
            
            IngredientDetailFieldRow(
                title: rightTitle,
                value: rightValue,
                icon: rightIcon
            )
        }
    }
}

@available(iOS 14.0, *)
struct IngredientDetailSingleRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        IngredientDetailFieldRow(
            title: title,
            value: value,
            icon: icon
        )
    }
}

@available(iOS 14.0, *)
struct IngredientDetailFieldRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.secondary)
                .font(.caption)
                .frame(width: 16)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(nil)
            }
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

@available(iOS 14.0, *)
extension DateFormatter {
   static let shortDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
