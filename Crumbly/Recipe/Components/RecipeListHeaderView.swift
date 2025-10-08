import SwiftUI

@available(iOS 14.0, *)
struct RecipeListHeaderView: View {
    @Binding var showingAddView: Bool
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.purple.opacity(0.8),
                    Color.blue.opacity(0.6),
                    Color.red.opacity(0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 100)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("My Recipes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    
                    Text("Discover & Create")
                        .font(.subheadline)
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
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                        
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .scaleEffect(1.0)
                .animation(.easeInOut(duration: 0.1))
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 0)
        )
    }
}
