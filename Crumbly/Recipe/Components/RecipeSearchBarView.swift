import SwiftUI

@available(iOS 14.0, *)
struct RecipeSearchBarView: View {
    @Binding var searchText: String
    @State private var isEditing = false
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isEditing ? Color.blue : Color.clear, lineWidth: 2)
                    )
                    .frame(height: 48)
                
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(isEditing ? .blue : .secondary)
                        .animation(.easeInOut(duration: 0.2))
                    
                    TextField("Search recipes...", text: $searchText, onEditingChanged: { editing in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isEditing = editing
                        }
                    })
                    .font(.body)
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                        }
                        .transition(.scale.combined(with: .opacity))
                        .animation(.easeInOut(duration: 0.2))
                    }
                }
                .padding(.horizontal, 16)
            }
            
            if isEditing {
                Button("Cancel") {
                    searchText = ""
                    isEditing = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .font(.body)
                .foregroundColor(.blue)
                .transition(.move(edge: .trailing).combined(with: .opacity))
                .animation(.easeInOut(duration: 0.2))
            }
        }
    }
}
