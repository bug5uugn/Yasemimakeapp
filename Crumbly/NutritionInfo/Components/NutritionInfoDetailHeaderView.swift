import SwiftUI

@available(iOS 14.0, *)
struct NutritionInfoDetailHeaderView: View {
    let nutritionInfo: NutritionInfo
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                VStack(spacing: 8) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.orange)
                    
                    Text("\(nutritionInfo.calories)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("CALORIES")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
                .frame(width: 100, height: 100)
                .background(
                    Circle()
                        .fill(Color.orange.opacity(0.1))
                        .overlay(
                            Circle()
                                .stroke(Color.orange.opacity(0.3), lineWidth: 2)
                        )
                )
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(nutritionInfo.dietType)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 8) {
                        if nutritionInfo.verified {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                        }
                        Text("Serving: \(nutritionInfo.servingSize)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 16) {
                        MacroProgressView(label: "Fat", value: nutritionInfo.fatGrams, color: .red)
                        MacroProgressView(label: "Carbs", value: nutritionInfo.carbsGrams, color: .blue)
                        MacroProgressView(label: "Protein", value: nutritionInfo.proteinGrams, color: .green)
                    }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.orange.opacity(0.05), Color.clear]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

@available(iOS 14.0, *)
struct MacroProgressView: View {
    let label: String
    let value: Int
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)g")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
