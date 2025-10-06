import SwiftUI

@available(iOS 14.0, *)
struct RecipeDetailView: View {
    let recipe: Recipe
    @ObservedObject var dataStore: RecipeDataStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Hero Header
                RecipeDetailHeaderView(recipe: recipe)
                
                // Content Sections
                VStack(spacing: 24) {
                    // Basic Information Section
                    RecipeDetailSectionView(
                        title: "Recipe Overview",
                        icon: "info.circle.fill",
                        color: .blue
                    ) {
                        VStack(spacing: 16) {
                            RecipeDetailInfoGridView(recipe: recipe)
                            
                            if !recipe.description.isEmpty {
                                RecipeDetailFieldRowView(
                                    icon: "doc.text.fill",
                                    title: "Description",
                                    value: recipe.description,
                                    color: .blue
                                )
                            }
                        }
                    }
                    
                    // Cooking Details Section
                    RecipeDetailSectionView(
                        title: "Cooking Information",
                        icon: "timer",
                        color: .orange
                    ) {
                        VStack(spacing: 12) {
                            HStack(spacing: 16) {
                                RecipeDetailMetricView(
                                    icon: "clock.fill",
                                    title: "Prep Time",
                                    value: "\(recipe.prepMinutes) min",
                                    color: .green
                                )
                                
                                RecipeDetailMetricView(
                                    icon: "flame.fill",
                                    title: "Cook Time",
                                    value: "\(recipe.cookMinutes) min",
                                    color: .red
                                )
                                
                                RecipeDetailMetricView(
                                    icon: "hourglass",
                                    title: "Total Time",
                                    value: "\(recipe.totalMinutes) min",
                                    color: .orange
                                )
                            }
                            
                            HStack(spacing: 16) {
                                RecipeDetailMetricView(
                                    icon: "person.2.fill",
                                    title: "Servings",
                                    value: "\(recipe.servings)",
                                    color: .blue
                                )
                                
                                RecipeDetailMetricView(
                                    icon: "chart.bar.fill",
                                    title: "Difficulty",
                                    value: recipe.difficulty,
                                    color: .purple
                                )
                                
                                RecipeDetailMetricView(
                                    icon: "star.fill",
                                    title: "Rating",
                                    value: "\(recipe.rating)/5",
                                    color: .yellow
                                )
                            }
                        }
                    }
                    
                    // Nutrition & Health Section
                    RecipeDetailSectionView(
                        title: "Nutrition & Health",
                        icon: "heart.fill",
                        color: .red
                    ) {
                        VStack(spacing: 12) {
                            HStack(spacing: 16) {
                                RecipeDetailMetricView(
                                    icon: "flame",
                                    title: "Calories",
                                    value: "\(recipe.calories)",
                                    color: .red
                                )
                                
                                RecipeDetailMetricView(
                                    icon: "scalemass.fill",
                                    title: "Portion Size",
                                    value: recipe.portionSize,
                                    color: .green
                                )
                                
                                RecipeDetailMetricView(
                                    icon: "dollarsign.circle.fill",
                                    title: "Cost Est.",
                                    value: String(format: "$%.2f", recipe.costEstimate),
                                    color: .green
                                )
                            }
                            
                            if !recipe.nutritionSummary.isEmpty {
                                RecipeDetailFieldRowView(
                                    icon: "chart.pie.fill",
                                    title: "Nutrition Summary",
                                    value: recipe.nutritionSummary,
                                    color: .red
                                )
                            }
                            
                            if !recipe.allergens.isEmpty {
                                RecipeDetailTagsView(
                                    icon: "exclamationmark.triangle.fill",
                                    title: "Allergens",
                                    tags: recipe.allergens,
                                    color: .orange
                                )
                            }
                        }
                    }
                    
                    // Recipe Details Section
                    RecipeDetailSectionView(
                        title: "Recipe Details",
                        icon: "book.fill",
                        color: .green
                    ) {
                        VStack(spacing: 12) {
                            RecipeDetailFieldRowView(
                                icon: "person.fill",
                                title: "Author",
                                value: recipe.author,
                                color: .blue
                            )
                            
                            RecipeDetailFieldRowView(
                                icon: "link",
                                title: "Source",
                                value: recipe.source,
                                color: .red
                            )
                            
                            HStack(spacing: 16) {
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
                                    color: .orange
                                )
                                
                                RecipeDetailMetricView(
                                    icon: "leaf.fill",
                                    title: "Season",
                                    value: recipe.season,
                                    color: .purple
                                )
                            }
                            
                            if !recipe.region.isEmpty {
                                RecipeDetailFieldRowView(
                                    icon: "map.fill",
                                    title: "Region",
                                    value: recipe.region,
                                    color: .yellow
                                )
                            }
                            
                            if !recipe.notes.isEmpty {
                                RecipeDetailFieldRowView(
                                    icon: "note.text",
                                    title: "Notes",
                                    value: recipe.notes,
                                    color: .secondary
                                )
                            }
                        }
                    }
                    
                    // Storage & Tips Section
                    RecipeDetailSectionView(
                        title: "Storage & Tips",
                        icon: "lightbulb.fill",
                        color: .yellow
                    ) {
                        VStack(spacing: 12) {
                            if !recipe.storageInstructions.isEmpty {
                                RecipeDetailFieldRowView(
                                    icon: "archivebox.fill",
                                    title: "Storage Instructions",
                                    value: recipe.storageInstructions,
                                    color: .orange
                                )
                            }
                            
                            if !recipe.tips.isEmpty {
                                RecipeDetailTagsView(
                                    icon: "lightbulb.fill",
                                    title: "Tips",
                                    tags: recipe.tips,
                                    color: .yellow
                                )
                            }
                            
                            if !recipe.variations.isEmpty {
                                RecipeDetailTagsView(
                                    icon: "arrow.triangle.branch",
                                    title: "Variations",
                                    tags: recipe.variations,
                                    color: .purple
                                )
                            }
                        }
                    }
                    
                    // Tags & Keywords Section
                    if !recipe.tags.isEmpty || !recipe.keywords.isEmpty {
                        RecipeDetailSectionView(
                            title: "Tags & Keywords",
                            icon: "tag.fill",
                            color: .purple
                        ) {
                            VStack(spacing: 12) {
                                if !recipe.tags.isEmpty {
                                    RecipeDetailTagsView(
                                        icon: "tag.fill",
                                        title: "Tags",
                                        tags: recipe.tags,
                                        color: .blue
                                    )
                                }
                                
                                if !recipe.keywords.isEmpty {
                                    RecipeDetailTagsView(
                                        icon: "magnifyingglass",
                                        title: "Keywords",
                                        tags: recipe.keywords,
                                        color: .green
                                    )
                                }
                            }
                        }
                    }
                    
                    // Media & Links Section
                    if !recipe.videoURL.isEmpty {
                        RecipeDetailSectionView(
                            title: "Media & Links",
                            icon: "video.fill",
                            color: .pink
                        ) {
                            RecipeDetailFieldRowView(
                                icon: "video.fill",
                                title: "Video Tutorial",
                                value: recipe.videoURL,
                                color: .pink
                            )
                        }
                    }
                    
                    // Status Information
                    RecipeDetailSectionView(
                        title: "Status Information",
                        icon: "checkmark.circle.fill",
                        color: .green
                    ) {
                        VStack(spacing: 12) {
                            HStack(spacing: 16) {
                                RecipeDetailStatusView(
                                    icon: recipe.isPublished ? "checkmark.circle.fill" : "xmark.circle.fill",
                                    title: "Published",
                                    isActive: recipe.isPublished,
                                    color: .green
                                )
                                
                                RecipeDetailStatusView(
                                    icon: recipe.isDraft ? "doc.badge.plus" : "doc.checkmark",
                                    title: "Draft",
                                    isActive: recipe.isDraft,
                                    color: .orange
                                )
                                
                                RecipeDetailStatusView(
                                    icon: recipe.isFavorite ? "heart.fill" : "heart",
                                    title: "Favorite",
                                    isActive: recipe.isFavorite,
                                    color: .red
                                )
                            }
                            
                            HStack(spacing: 16) {
                                RecipeDetailMetricView(
                                    icon: "calendar.badge.plus",
                                    title: "Created",
                                    value: DateFormatter.shortDate.string(from: recipe.createdAt),
                                    color: .blue
                                )
                                
                                RecipeDetailMetricView(
                                    icon: "calendar.badge.clock",
                                    title: "Updated",
                                    value: DateFormatter.shortDate.string(from: recipe.updatedAt),
                                    color: .yellow
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 6) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                Text("Back")
                    .font(.body)
            }
            .foregroundColor(.blue)
        })
    }
}
