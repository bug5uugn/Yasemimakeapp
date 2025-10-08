import SwiftUI

@available(iOS 14.0, *)
struct RecipeDetailTagsView: View {
    let icon: String
    let title: String
    let tags: [String]
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
            }
            
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 80))
            ], spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(color.opacity(0.15))
                        .foregroundColor(color)
                        .clipShape(Capsule())
                }
            }
        }
    }
}
