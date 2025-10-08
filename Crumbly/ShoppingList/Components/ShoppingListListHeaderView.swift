import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListListHeaderView: View {
    @Binding var showingAddView: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.green, Color.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 140)
            .clipShape(
                RoundedRectangle(cornerRadius: 0)
            )
            
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Shopping Lists")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Organize your shopping efficiently")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showingAddView = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .scaleEffect(1.0)
                    .animation(.spring(response: 0.3), value: showingAddView)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}
