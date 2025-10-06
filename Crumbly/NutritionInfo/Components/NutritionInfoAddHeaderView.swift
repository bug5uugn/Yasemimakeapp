import SwiftUI

@available(iOS 14.0, *)
struct NutritionInfoAddHeaderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "chart.pie.fill")
                .font(.system(size: 60))
                .foregroundColor(.orange)
                .background(
                    Circle()
                        .fill(Color.orange.opacity(0.1))
                        .frame(width: 100, height: 100)
                )
            
            VStack(spacing: 8) {
                Text("Add Nutrition Information")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Enter detailed nutritional data for your food item")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.orange.opacity(0.05), Color.clear]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
