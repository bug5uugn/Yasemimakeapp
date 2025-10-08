import SwiftUI

@available(iOS 14.0, *)
struct RecipeListRowView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Card
            VStack(alignment: .leading, spacing: 16) {
                // Header Section
                HStack(alignment: .top, spacing: 12) {
                    // Recipe Image Placeholder
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.orange.opacity(0.3),
                                        Color.red.opacity(0.2)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "fork.knife.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                    }
                    
                    // Title and Basic Info
                    VStack(alignment: .leading, spacing: 6) {
                        Text(recipe.title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
                        Text(recipe.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                        
                        HStack(spacing: 16) {
                            RecipeListBadgeView(
                                icon: "star.fill",
                                text: "\(recipe.rating)",
                                color: .yellow
                            )
                            
                            RecipeListBadgeView(
                                icon: "person.2.fill",
                                text: "\(recipe.servings)",
                                color: .blue
                            )
                            
                            if recipe.isFavorite {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                // Recipe Details Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    RecipeListDetailView(
                        icon: "clock.fill",
                        title: "Total Time",
                        value: "\(recipe.totalMinutes) min",
                        color: .orange
                    )
                    
                    RecipeListDetailView(
                        icon: "chart.bar.fill",
                        title: "Difficulty",
                        value: recipe.difficulty,
                        color: .purple
                    )
                    
                    RecipeListDetailView(
                        icon: "flame.fill",
                        title: "Calories",
                        value: "\(recipe.calories)",
                        color: .red
                    )
                    
                    RecipeListDetailView(
                        icon: "folder.fill",
                        title: "Category",
                        value: recipe.category,
                        color: .green
                    )
                    
                    RecipeListDetailView(
                        icon: "globe",
                        title: "Cuisine",
                        value: recipe.cuisine,
                        color: .pink
                    )
                    
                    RecipeListDetailView(
                        icon: "dollarsign.circle.fill",
                        title: "Cost",
                        value: String(format: "$%.2f", recipe.costEstimate),
                        color: .red
                    )
                }
                
                // Additional Information
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        
                        Text("By \(recipe.author)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Image(systemName: "calendar")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        
                        Text(recipe.season)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    if !recipe.tags.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 6) {
                                ForEach(recipe.tags.prefix(5), id: \.self) { tag in
                                    Text(tag)
                                        .font(.caption2)
                                        .fontWeight(.medium)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.1))
                                        .foregroundColor(.blue)
                                        .clipShape(Capsule())
                                }
                            }
                            .padding(.horizontal, 1)
                        }
                    }
                    
                    // Nutrition and Storage Info
                    VStack(alignment: .leading, spacing: 4) {
                        if !recipe.nutritionSummary.isEmpty {
                            HStack {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(.red)
                                
                                Text(recipe.nutritionSummary)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                        }
                        
                        if !recipe.storageInstructions.isEmpty {
                            HStack {
                                Image(systemName: "archivebox.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(.pink)
                                
                                Text(recipe.storageInstructions)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            }
            .padding(20)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
        }
    }
}
