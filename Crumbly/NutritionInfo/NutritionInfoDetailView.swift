import SwiftUI

@available(iOS 14.0, *)
struct NutritionInfoDetailView: View {
    let nutritionInfo: NutritionInfo
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                NutritionInfoDetailHeaderView(nutritionInfo: nutritionInfo)
                
                VStack(spacing: 20) {
                    NutritionInfoDetailSectionView(
                        title: "Macronutrients",
                        icon: "chart.bar.fill",
                        color: .blue,
                        content: {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                                NutritionInfoDetailFieldRow(label: "Calories", value: "\(nutritionInfo.calories)", unit: "kcal", icon: "flame.fill", color: .orange)
                                NutritionInfoDetailFieldRow(label: "Total Fat", value: "\(nutritionInfo.fatGrams)", unit: "g", icon: "drop.fill", color: .red)
                                NutritionInfoDetailFieldRow(label: "Carbohydrates", value: "\(nutritionInfo.carbsGrams)", unit: "g", icon: "leaf.fill", color: .green)
                                NutritionInfoDetailFieldRow(label: "Protein", value: "\(nutritionInfo.proteinGrams)", unit: "g", icon: "bolt.fill", color: .blue)
                                NutritionInfoDetailFieldRow(label: "Fiber", value: "\(nutritionInfo.fiberGrams)", unit: "g", icon: "tree.fill", color: .red)
                                NutritionInfoDetailFieldRow(label: "Sugar", value: "\(nutritionInfo.sugarGrams)", unit: "g", icon: "cube.fill", color: .pink)
                            }
                        }
                    )
                    
                    NutritionInfoDetailSectionView(
                        title: "Fat Breakdown",
                        icon: "drop.circle.fill",
                        color: .red,
                        content: {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                                NutritionInfoDetailFieldRow(label: "Saturated Fat", value: "\(nutritionInfo.saturatedFat)", unit: "g", icon: "minus.circle.fill", color: .red)
                                NutritionInfoDetailFieldRow(label: "Trans Fat", value: "\(nutritionInfo.transFat)", unit: "g", icon: "xmark.circle.fill", color: .red)
                                NutritionInfoDetailFieldRow(label: "Unsaturated Fat", value: "\(nutritionInfo.unsaturatedFat)", unit: "g", icon: "plus.circle.fill", color: .green)
                                NutritionInfoDetailFieldRow(label: "Omega-3", value: "\(nutritionInfo.omega3)", unit: "g", icon: "wave.3.right", color: .blue)
                                NutritionInfoDetailFieldRow(label: "Omega-6", value: "\(nutritionInfo.omega6)", unit: "g", icon: "wave.3.left", color: .purple)
                                NutritionInfoDetailFieldRow(label: "Water Content", value: "\(nutritionInfo.waterContent)", unit: "%", icon: "drop.fill", color: .green)
                            }
                        }
                    )
                    
                    NutritionInfoDetailSectionView(
                        title: "Vitamins & Minerals",
                        icon: "pills.fill",
                        color: .green,
                        content: {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                                NutritionInfoDetailFieldRow(label: "Vitamin A", value: "\(nutritionInfo.vitaminA)", unit: "%", icon: "eye.fill", color: .orange)
                                NutritionInfoDetailFieldRow(label: "Vitamin C", value: "\(nutritionInfo.vitaminC)", unit: "%", icon: "c.circle.fill", color: .yellow)
                                NutritionInfoDetailFieldRow(label: "Vitamin D", value: "\(nutritionInfo.vitaminD)", unit: "%", icon: "sun.max.fill", color: .yellow)
                                NutritionInfoDetailFieldRow(label: "Calcium", value: "\(nutritionInfo.calciumMg)", unit: "mg", icon: "bone", color: .gray)
                                NutritionInfoDetailFieldRow(label: "Iron", value: "\(nutritionInfo.ironMg)", unit: "mg", icon: "shield.fill", color: .red)
                                NutritionInfoDetailFieldRow(label: "Potassium", value: "\(nutritionInfo.potassiumMg)", unit: "mg", icon: "bolt.circle.fill", color: .blue)
                            }
                        }
                    )
                    
                    NutritionInfoDetailSectionView(
                        title: "Additional Minerals",
                        icon: "atom",
                        color: .purple,
                        content: {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                                NutritionInfoDetailFieldRow(label: "Sodium", value: "\(nutritionInfo.sodiumMg)", unit: "mg", icon: "drop.triangle.fill", color: .purple)
                                NutritionInfoDetailFieldRow(label: "Cholesterol", value: "\(nutritionInfo.cholesterolMg)", unit: "mg", icon: "heart.fill", color: .pink)
                                NutritionInfoDetailFieldRow(label: "Caffeine", value: "\(nutritionInfo.caffeineMg)", unit: "mg", icon: "cup.and.saucer.fill", color: .purple)
                                NutritionInfoDetailFieldRow(label: "Alcohol", value: "\(nutritionInfo.alcoholContent)", unit: "%", icon: "wineglass.fill", color: .red)
                            }
                        }
                    )
                    
                    NutritionInfoDetailSectionView(
                        title: "Serving Information",
                        icon: "scalemass.fill",
                        color: .orange,
                        content: {
                            VStack(spacing: 12) {
                                NutritionInfoDetailInfoRow(label: "Serving Size", value: nutritionInfo.servingSize, icon: "scalemass.fill")
                                NutritionInfoDetailInfoRow(label: "Servings per Container", value: "\(nutritionInfo.servingsPerContainer)", icon: "number.circle.fill")
                                NutritionInfoDetailInfoRow(label: "Diet Type", value: nutritionInfo.dietType, icon: "leaf.circle.fill")
                                NutritionInfoDetailInfoRow(label: "Region", value: nutritionInfo.region, icon: "globe")
                                NutritionInfoDetailInfoRow(label: "Certification", value: nutritionInfo.certification, icon: "checkmark.seal.fill")
                            }
                        }
                    )
                    
                    NutritionInfoDetailSectionView(
                        title: "Diet Preferences",
                        icon: "checkmark.circle.fill",
                        color: .green,
                        content: {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                                NutritionInfoDetailBooleanRow(label: "Gluten Free", value: nutritionInfo.isGlutenFree, icon: "g.circle.fill")
                                NutritionInfoDetailBooleanRow(label: "Vegan", value: nutritionInfo.isVegan, icon: "leaf.fill")
                                NutritionInfoDetailBooleanRow(label: "Vegetarian", value: nutritionInfo.isVegetarian, icon: "carrot.fill")
                                NutritionInfoDetailBooleanRow(label: "Organic", value: nutritionInfo.isOrganic, icon: "seal.fill")
                            }
                        }
                    )
                    
                    if !nutritionInfo.allergens.isEmpty {
                        NutritionInfoDetailSectionView(
                            title: "Allergens",
                            icon: "exclamationmark.triangle.fill",
                            color: .red,
                            content: {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                                    ForEach(nutritionInfo.allergens, id: \.self) { allergen in
                                        NutritionInfoDetailAllergenTag(allergen: allergen)
                                    }
                                }
                            }
                        )
                    }
                    
                    NutritionInfoDetailSectionView(
                        title: "Metadata",
                        icon: "info.circle.fill",
                        color: .gray,
                        content: {
                            VStack(spacing: 12) {
                                NutritionInfoDetailInfoRow(label: "Calculated At", value: DateFormatter.shortDate.string(from: nutritionInfo.calculatedAt), icon: "calendar")
                                NutritionInfoDetailInfoRow(label: "Verified", value: nutritionInfo.verified ? "Yes" : "No", icon: nutritionInfo.verified ? "checkmark.circle.fill" : "xmark.circle.fill")
                            }
                        }
                    )
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitle("Nutrition Details", displayMode: .inline)
    }
}

@available(iOS 14.0, *)
extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
