import SwiftUI

@available(iOS 14.0, *)
struct RecipeDetailInfoGridView: View {
    let recipe: Recipe
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 12) {
            RecipeDetailMetricView(
                icon: "folder.fill",
                title: "Category",
                value: recipe.category,
                color: .green
            )
            
            RecipeDetailMetricView(
                icon: "globe",
                title: "Cuisine",
                value: recipe.cuisine,
                color: .blue
            )
            
            RecipeDetailMetricView(
                icon: "chart.bar.fill",
                title: "Difficulty",
                value: recipe.difficulty,
                color: .purple
            )
            
            RecipeDetailMetricView(
                icon: "leaf.fill",
                title: "Season",
                value: recipe.season,
                color: .green
            )
        }
    }
}
