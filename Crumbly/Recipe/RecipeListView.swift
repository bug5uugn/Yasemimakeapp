import SwiftUI

@available(iOS 14.0, *)
struct RecipeListView: View {
    @ObservedObject var dataStore: RecipeDataStore
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    @State private var showingAddView = false
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return dataStore.recipes
        } else {
            return dataStore.recipes.filter { recipe in
                recipe.title.localizedCaseInsensitiveContains(searchText) ||
                recipe.description.localizedCaseInsensitiveContains(searchText) ||
                recipe.category.localizedCaseInsensitiveContains(searchText) ||
                recipe.cuisine.localizedCaseInsensitiveContains(searchText) ||
                recipe.author.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
           
            VStack(spacing: 0) {
                HStack {
                    
                    
                    Spacer()
                    
                    Text("Recipes")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Add Button
                    Button(action: { showingAddView = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 8)
                
                Divider()
                
                // Search Bar
                RecipeSearchBarView(searchText: $searchText)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                // Content
                if filteredRecipes.isEmpty {
                    if dataStore.recipes.isEmpty {
                        RecipeNoDataView(
                            title: "No Recipes Yet",
                            subtitle: "Start building your recipe collection",
                            imageName: "book.closed.fill"
                        )
                    } else {
                        RecipeNoDataView(
                            title: "No Results Found",
                            subtitle: "Try adjusting your search terms",
                            imageName: "magnifyingglass"
                        )
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredRecipes) { recipe in
                                NavigationLink(
                                    destination: RecipeDetailView(recipe: recipe, dataStore: dataStore)
                                ) {
                                    RecipeListRowView(recipe: recipe)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddView) {
            RecipeAddView(dataStore: dataStore)
        }
    }
}

