import SwiftUI

@available(iOS 14.0, *)
struct ShoppingListListView: View {
    @ObservedObject var dataStore: RecipeDataStore
    @State private var searchText = ""
    @State private var showingAddView = false
    @Environment(\.presentationMode) private var presentationMode
    
    private var filteredLists: [ShoppingList] {
        if searchText.isEmpty {
            return dataStore.shoppingLists
        } else {
            return dataStore.shoppingLists.filter { list in
                list.title.localizedCaseInsensitiveContains(searchText) ||
                list.category.localizedCaseInsensitiveContains(searchText) ||
                list.store.localizedCaseInsensitiveContains(searchText) ||
                list.tags.joined().localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
            ZStack {
              
                VStack(spacing: 0) {
                    
                    // MARK: - Custom Navigation Bar
                    HStack {
                       
                        Spacer()
                        
                        Text("Shopping Lists")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        Button(action: { showingAddView = true }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    .padding(.bottom, 8)

                    ShoppingListSearchBarView(searchText: $searchText)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // MARK: - Content
                    if filteredLists.isEmpty {
                        Spacer()
                        if dataStore.shoppingLists.isEmpty {
                            ShoppingListNoDataView(
                                title: "No Shopping Lists",
                                subtitle: "Create your first shopping list to get started",
                                iconName: "cart.badge.plus",
                                actionTitle: "Create List",
                                action: { showingAddView = true }
                            )
                        } else {
                            ShoppingListNoDataView(
                                title: "No Results Found",
                                subtitle: "Try adjusting your search terms",
                                iconName: "magnifyingglass",
                                actionTitle: "Clear Search",
                                action: { searchText = "" }
                            )
                        }
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 14) {
                                ForEach(filteredLists) { list in
                                    NavigationLink(
                                        destination: ShoppingListDetailView(
                                            shoppingList: list,
                                            dataStore: dataStore
                                        )
                                    ) {
                                        ShoppingListListRowView(shoppingList: list)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .onLongPressGesture {
                                        deleteList(list)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            .padding(.bottom, 80)
                        }
                    }
                }
            }        
        .sheet(isPresented: $showingAddView) {
            ShoppingListAddView(dataStore: dataStore)
        }
    }
    
    private func deleteList(_ list: ShoppingList) {
        withAnimation(.spring()) {
            dataStore.deleteShoppingList(list)
        }
    }
}

