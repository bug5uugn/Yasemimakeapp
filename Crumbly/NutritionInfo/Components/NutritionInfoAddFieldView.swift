import SwiftUI

@available(iOS 14.0, *)
struct NutritionInfoAddFieldView: View {
    let title: String
    @Binding var text: String
    let icon: String
    var keyboardType: UIKeyboardType = .default
    
    @State private var isFocused = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.blue)
                    .frame(width: 16)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
            
            TextField("Enter \(title.lowercased())", text: $text, onEditingChanged: { focused in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isFocused = focused
                }
            })
            .keyboardType(keyboardType)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isFocused ? Color.blue : Color(.systemGray4), lineWidth: isFocused ? 2 : 1)
                    )
            )
            .shadow(color: isFocused ? Color.blue.opacity(0.2) : Color.clear, radius: 4, x: 0, y: 2)
        }
    }
}
