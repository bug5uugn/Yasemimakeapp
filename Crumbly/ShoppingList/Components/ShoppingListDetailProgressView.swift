import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListDetailProgressView: View {
    let shoppingList: ShoppingList
    
    private var completionPercentage: Double {
        let total = shoppingList.items.count
        let completed = shoppingList.completedItems.count
        return total > 0 ? Double(completed) / Double(total) : 0.0
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Shopping Progress")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("\(Int(completionPercentage * 100))%")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(shoppingList.colorHex))
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray5))
                        .frame(height: 16)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(shoppingList.colorHex), Color(shoppingList.colorHex).opacity(0.7)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * completionPercentage, height: 16)
                        .animation(.easeInOut(duration: 0.5), value: completionPercentage)
                }
            }
            .frame(height: 16)
            
            HStack {
                Text("\(shoppingList.completedItems.count) completed")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.green)
                
                Spacer()
                
                Text("\(shoppingList.pendingItems.count) pending")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.orange)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
    }
}
