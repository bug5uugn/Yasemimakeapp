import SwiftUI

@available(iOS 14.0, *)
struct NutritionInfoAddToggleView: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(isOn ? .green : .gray)
                .frame(width: 24)
            
            Text(title)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .green))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
    }
}
