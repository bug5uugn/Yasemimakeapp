import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListAddSliderView: View {
    let title: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.red)
                    .frame(width: 20)
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("\(value)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.red)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.red.opacity(0.1))
                    )
            }
            
            Slider(
                value: Binding(
                    get: { Double(value) },
                    set: { value = Int($0) }
                ),
                in: Double(range.lowerBound)...Double(range.upperBound),
                step: 1
            )
            .accentColor(.red)
        }
        .padding(.vertical, 4)
    }
}
