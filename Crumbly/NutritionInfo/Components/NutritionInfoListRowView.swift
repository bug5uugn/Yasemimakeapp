import SwiftUI

@available(iOS 14.0, *)
struct NutritionInfoListRowView: View {
    let nutritionInfo: NutritionInfo
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Section
            HStack(spacing: 16) {
                VStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.orange)
                    
                    Text("\(nutritionInfo.calories)")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("calories")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .frame(width: 60)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.orange.opacity(0.1))
                )
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(nutritionInfo.dietType)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if nutritionInfo.verified {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.green)
                        }
                    }
                    
                    Text("Serving: \(nutritionInfo.servingSize)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 16) {
                        NutritionInfoMacroChip(label: "Fat", value: "\(nutritionInfo.fatGrams)g", color: .red)
                        NutritionInfoMacroChip(label: "Carbs", value: "\(nutritionInfo.carbsGrams)g", color: .blue)
                        NutritionInfoMacroChip(label: "Protein", value: "\(nutritionInfo.proteinGrams)g", color: .green)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
            Divider()
                .padding(.horizontal, 20)
            
            // Details Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                NutritionInfoDetailChip(icon: "drop.fill", label: "Sodium", value: "\(nutritionInfo.sodiumMg)mg", color: .purple)
                NutritionInfoDetailChip(icon: "heart.fill", label: "Cholesterol", value: "\(nutritionInfo.cholesterolMg)mg", color: .pink)
                NutritionInfoDetailChip(icon: "bolt.circle.fill", label: "Potassium", value: "\(nutritionInfo.potassiumMg)mg", color: .yellow)
                NutritionInfoDetailChip(icon: "eye.fill", label: "Vit A", value: "\(nutritionInfo.vitaminA)%", color: .orange)
                NutritionInfoDetailChip(icon: "c.circle.fill", label: "Vit C", value: "\(nutritionInfo.vitaminC)%", color: .green)
                NutritionInfoDetailChip(icon: "sun.max.fill", label: "Vit D", value: "\(nutritionInfo.vitaminD)%", color: .yellow)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
            Divider()
                .padding(.horizontal, 20)
            
            // Diet Tags
            HStack(spacing: 8) {
                if nutritionInfo.isVegan {
                    NutritionInfoDietTag(text: "Vegan", color: .green)
                }
                if nutritionInfo.isVegetarian {
                    NutritionInfoDietTag(text: "Vegetarian", color: .blue)
                }
                if nutritionInfo.isGlutenFree {
                    NutritionInfoDietTag(text: "Gluten Free", color: .orange)
                }
                if nutritionInfo.isOrganic {
                    NutritionInfoDietTag(text: "Organic", color: .gray)
                }
                
                Spacer()
                
                Text(nutritionInfo.region)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color(.systemGray6))
                    )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
    }
}

@available(iOS 14.0, *)
struct NutritionInfoMacroChip: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(color.opacity(0.1))
        )
    }
}

@available(iOS 14.0, *)
struct NutritionInfoDetailChip: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(color)
            
            Text(value)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(color.opacity(0.08))
        )
    }
}

@available(iOS 14.0, *)
struct NutritionInfoDietTag: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.caption2)
            .fontWeight(.medium)
            .foregroundColor(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .fill(color.opacity(0.15))
            )
    }
}
