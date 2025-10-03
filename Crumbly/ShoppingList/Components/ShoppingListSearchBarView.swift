import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListSearchBarView: View {
    @Binding var searchText: String
    @State private var isEditing = false
    
    var body: some View {
        HStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(isEditing ? .blue : .secondary)
                    .animation(.easeInOut(duration: 0.2), value: isEditing)
                
                TextField("Search lists, stores, categories...", text: $searchText, onEditingChanged: { editing in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isEditing = editing
                    }
                })
                .font(.system(size: 16))
                .textFieldStyle(PlainTextFieldStyle())
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isEditing ? Color.blue : Color.clear, lineWidth: 2)
                    )
            )
            .scaleEffect(isEditing ? 1.02 : 1.0)
            .animation(.spring(response: 0.3), value: isEditing)
        }
    }
}
