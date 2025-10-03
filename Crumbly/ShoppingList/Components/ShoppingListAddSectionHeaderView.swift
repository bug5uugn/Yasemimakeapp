import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListAddSectionHeaderView: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(color)
            }
            
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            Spacer()
            
            Rectangle()
                .fill(color.opacity(0.3))
                .frame(height: 2)
                .frame(maxWidth: 60)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
}
