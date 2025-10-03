import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListAddHeaderView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 120)
            .clipShape(
                RoundedRectangle(cornerRadius: 0)
                    .path(in: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120))
            )
            
            VStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Create Shopping List")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Add all the details for your new list")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(.top, 20)
        }
    }
}
