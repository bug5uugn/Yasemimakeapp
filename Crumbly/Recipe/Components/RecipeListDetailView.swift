import SwiftUI

@available(iOS 14.0, *)
struct RecipeListDetailView: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(color)
            
            Text(title)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
            
            Text(value)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(color.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
