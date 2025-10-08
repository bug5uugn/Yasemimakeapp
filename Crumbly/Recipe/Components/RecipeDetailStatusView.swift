import SwiftUI

@available(iOS 14.0, *)
struct RecipeDetailStatusView: View {
    let icon: String
    let title: String
    let isActive: Bool
    let color: Color
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(isActive ? color : .secondary)
            
            Text(title)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
            
            Circle()
                .fill(isActive ? color : Color.secondary)
                .frame(width: 8, height: 8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background((isActive ? color : Color.secondary).opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
