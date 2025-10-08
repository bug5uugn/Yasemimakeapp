import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListDetailStatusItem: View {
    let label: String
    let isActive: Bool
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isActive ? .green : .gray)
                .frame(width: 16)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
                
                Text(isActive ? "Yes" : "No")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isActive ? .green : .gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
