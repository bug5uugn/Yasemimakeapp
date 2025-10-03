
import SwiftUI

@available(iOS 14.0, *)
struct IngredientListView: View {
    @ObservedObject var store: RecipeDataStore
    @State private var searchText = ""
    @State private var showingAddView = false
    
    var filteredIngredients: [Ingredient] {
        if searchText.isEmpty {
            return store.ingredients
        } else {
            return store.ingredients.filter { ingredient in
                ingredient.name.localizedCaseInsensitiveContains(searchText) ||
                ingredient.category.localizedCaseInsensitiveContains(searchText) ||
                ingredient.brand.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
            VStack(spacing: 0) {
                
                IngredientSearchBarView(searchText: $searchText)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                
                if filteredIngredients.isEmpty {
                    IngredientNoDataView(hasSearchText: !searchText.isEmpty)
                        .padding(.top, 50)
                } else {
                    List {
                        ForEach(filteredIngredients) { ingredient in
                            NavigationLink(
                                destination: IngredientDetailView(ingredient: ingredient, store: store)
                            ) {
                                IngredientListRowView(ingredient: ingredient)
                            }
                        }
                        .onDelete(perform: deleteIngredient)
                    }
                }
            }
            .navigationTitle("Ingredients")
            .navigationBarItems(
                trailing: Button(action: { showingAddView = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.green)
                }
            )
            .sheet(isPresented: $showingAddView) {
                IngredientAddView(store: store)
            }
        
    }
    
    private func deleteIngredient(at offsets: IndexSet) {
        for index in offsets {
            let ingredient = filteredIngredients[index]
            if let actualIndex = store.ingredients.firstIndex(where: { $0.id == ingredient.id }) {
                store.ingredients.remove(at: actualIndex)
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientListHeaderView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("My Ingredients")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Manage your ingredient collection")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "leaf.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.green)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
        .padding(.bottom, 20)
        .background(Color(.systemBackground))
    }
}

@available(iOS 14.0, *)
struct IngredientSearchBarView: View {
    @Binding var searchText: String
    @State private var isSearching = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .font(.system(size: 16, weight: .medium))
                
                TextField("Search ingredients...", text: $searchText, onEditingChanged: { editing in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isSearching = editing
                    }
                })
                .font(.system(size: 16))
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .scaleEffect(isSearching ? 1.02 : 1.0)
            
            if isSearching {
                Button("Cancel") {
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isSearching = false
                    }
                }
                .foregroundColor(.orange)
                .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut(duration: 0.3))
    }
}

@available(iOS 14.0, *)
struct IngredientListRowView: View {
    
    let ingredient: Ingredient
    @State private var offset: CGFloat = 0
    @State private var showingDeleteButton = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                HStack{
                    
                    IngredientListIconView(ingredient: ingredient)
                    
                    Spacer()
                    IngredientListStatusView(ingredient: ingredient)
                    
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    VStack {
                        IngredientListTitleSection(ingredient: ingredient)
                        
                    }
                    
                    IngredientListDetailsSection(ingredient: ingredient)
                    
                    IngredientListNutritionSection(ingredient: ingredient)
                    
                    IngredientListTagsSection(ingredient: ingredient)
                }
            }
            .padding(20)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            
        }
    }
}


@available(iOS 14.0, *)
struct IngredientListIconView: View {
    let ingredient: Ingredient
    
    var categoryColor: Color {
        switch ingredient.category.lowercased() {
        case "vegetables": return .green
        case "fruits": return .orange
        case "grains": return .yellow
        case "proteins": return .red
        case "dairy": return .blue
        case "oils & fats": return .purple
        case "spices": return .yellow
        case "herbs": return .pink
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
        VStack {
            Image(systemName: categoryIcon)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [categoryColor, categoryColor.opacity(0.7)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(12)
                .shadow(color: categoryColor.opacity(0.3), radius: 5, x: 0, y: 2)
        }
    }
}

@available(iOS 14.0, *)
struct IngredientListTitleSection: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack {
            Text(ingredient.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(1)
            
            Spacer()
            
            if ingredient.organic {
                Image(systemName: "leaf.fill")
                    .foregroundColor(.green)
                    .font(.caption)
            }
        }
        
        HStack {
            Text("\(ingredient.amount) \(ingredient.unit)")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            Text("•")
                .foregroundColor(.secondary)
            
            Text(ingredient.category)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text("$\(ingredient.cost, specifier: "%.2f")")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.green)
        }
    }
}

@available(iOS 14.0, *)
struct IngredientListDetailsSection: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack {
            Label(ingredient.brand, systemImage: "tag.fill")
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            Spacer()
            
            Label(ingredient.origin, systemImage: "globe")
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        
        HStack {
            Label(ingredient.storageLocation, systemImage: "house.fill")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text("Expires: \(ingredient.expiryDate, formatter: dateFormatter)")
                .font(.caption)
                .foregroundColor(ingredient.expiryDate < Date() ? .red : .secondary)
        }
    }
}

@available(iOS 14.0, *)
struct IngredientListNutritionSection: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack(spacing: 15) {
            IngredientNutritionBadge(
                value: ingredient.calories,
                unit: "cal",
                color: .orange,
                icon: "flame.fill"
            )
            
            IngredientNutritionBadge(
                value: ingredient.protein,
                unit: "g protein",
                color: .red,
                icon: "p.circle.fill"
            )
            
            IngredientNutritionBadge(
                value: ingredient.carbs,
                unit: "g carbs",
                color: .blue,
                icon: "c.circle.fill"
            )
            
            Spacer()
        }
    }
}

@available(iOS 14.0, *)
struct IngredientNutritionBadge: View {
    let value: Int
    let unit: String
    let color: Color
    let icon: String
    
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: icon)
                .font(.system(size: 10))
                .foregroundColor(color)
            
            Text("\(value)")
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundColor(color)
            
            Text(unit)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 3)
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

@available(iOS 14.0, *)
struct IngredientListTagsSection: View {
    let ingredient: Ingredient
    
    var dietaryTags: [String] {
        var tags: [String] = []
        if ingredient.vegan { tags.append("Vegan") }
        if ingredient.vegetarian { tags.append("Vegetarian") }
        if ingredient.glutenFree { tags.append("Gluten-Free") }
        if ingredient.organic { tags.append("Organic") }
        if ingredient.halal { tags.append("Halal") }
        if ingredient.kosher { tags.append("Kosher") }
        return tags
    }
    
    var body: some View {
        if !dietaryTags.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(dietaryTags.prefix(4), id: \.self) { tag in
                        Text(tag)
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(tagColor(for: tag))
                            .cornerRadius(10)
                    }
                    
                    if dietaryTags.count > 4 {
                        Text("+\(dietaryTags.count - 4)")
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
    
    private func tagColor(for tag: String) -> Color {
        switch tag.lowercased() {
        case "vegan": return .green
        case "vegetarian": return .orange
        case "gluten-free": return .orange
        case "organic": return .red
        case "halal": return .blue
        case "kosher": return .purple
        default: return .gray
        }
    }
}

@available(iOS 14.0, *)
struct IngredientListStatusView: View {
    let ingredient: Ingredient
    
    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(ingredient.isAvailable ? Color.green : Color.red)
                .frame(width: 12, height: 12)
            
            Text(ingredient.isAvailable ? "Available" : "Out of Stock")
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(ingredient.isAvailable ? .green : .red)
                .multilineTextAlignment(.center)
            
            if ingredient.isOptional {
                Image(systemName: "questionmark.circle.fill")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
        }
    }
}

@available(iOS 14.0, *)
struct IngredientNoDataView: View {
    let hasSearchText: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: hasSearchText ? "magnifyingglass" : "leaf.fill")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text(hasSearchText ? "No Results Found" : "No Ingredients Yet")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(hasSearchText ? "Try adjusting your search terms" : "Add your first ingredient to get started")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            if !hasSearchText {
                Button("Add Ingredient") {
                   
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 12)
                .background(Color.green)
                .cornerRadius(25)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
