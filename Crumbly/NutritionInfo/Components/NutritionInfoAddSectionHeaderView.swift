import SwiftUI

@available(iOS 14.0, *)
struct NutritionInfoAddSectionHeaderView: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(color)
                .frame(width: 32, height: 32)
                .background(
                    Circle()
                        .fill(color.opacity(0.15))
                )
            
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Spacer()
            
            Rectangle()
                .fill(color.opacity(0.3))
                .frame(height: 2)
                .frame(maxWidth: 60)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}
