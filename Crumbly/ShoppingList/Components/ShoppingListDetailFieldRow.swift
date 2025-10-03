import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListDetailFieldRow: View {
    let label: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(color)
                    .frame(width: 16)
                
                Text(label)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            
            Text(value)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
                .padding(.leading, 24)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
