
import SwiftUI

@available(iOS 14.0, *)
struct DashboardView: View {
    @ObservedObject var dataStore = RecipeDataStore()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("Recipe Dashboard")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    HStack(spacing: 15) {
                        StatCard(title: "Recipes",
                                 value: "\(dataStore.recipes.count)",
                                 color: .orange,
                                 icon: "book.fill")
                        
                        StatCard(title: "Ingredients",
                                 value: "\(dataStore.ingredients.count)",
                                 color: .green,
                                 icon: "leaf.fill")
                    }
                    
                    HStack(spacing: 15) {
                        StatCard(title: "Steps",
                                 value: "\(dataStore.steps.count)",
                                 color: .blue,
                                 icon: "list.number")
                        
                        StatCard(title: "Shopping",
                                 value: "\(dataStore.shoppingLists.count)",
                                 color: .purple,
                                 icon: "cart.fill")
                    }
                    
                    HStack(spacing: 15) {
                        StatCard(title: "Nutrition",
                                 value: "\(dataStore.nutritionInfos.count)",
                                 color: .pink,
                                 icon: "heart.fill")
                        
                        StatCard(title: "Timers",
                                 value: "\(dataStore.timers.count)",
                                 color: .red,
                                 icon: "timer")
                    }
                    
                    Divider().padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        NavigationLink(destination: RecipeListView(dataStore: dataStore)) {
                            DashboardLinkRow(title: "Recipes", icon: "book.fill", color: .orange)
                        }
                        NavigationLink(destination: IngredientListView(store : dataStore)) {
                            DashboardLinkRow(title: "Ingredients", icon: "leaf.fill", color: .green)
                        }
                        NavigationLink(destination: RecipeStepListView(dataStore: dataStore)) {
                            DashboardLinkRow(title: "Steps", icon: "list.number", color: .blue)
                        }
                        NavigationLink(destination: ShoppingListListView(dataStore: dataStore)) {
                            DashboardLinkRow(title: "Shopping Lists", icon: "cart.fill", color: .purple)
                        }
                        NavigationLink(destination: NutritionInfoListView(store : dataStore)) {
                            DashboardLinkRow(title: "Nutrition Info", icon: "heart.fill", color: .pink)
                        }
                        NavigationLink(destination: RecipeTimerListView(dataStore: dataStore)) {
                            DashboardLinkRow(title: "Timers", icon: "timer", color: .red)
                        }
                    }
                    
                    
                    Spacer()
                }.padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
}

@available(iOS 14.0, *)
struct StatCard: View {
    var title: String
    var value: String
    var color: Color
    var icon: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(color)
                    .clipShape(Circle())
                
                Spacer()
                
                Text(value)
                    .font(.title)
                    .bold()
            }
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 4)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

@available(iOS 14.0, *)
struct DashboardLinkRow: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .padding(8)
                .background(color)
                .clipShape(Circle())
            Text(title)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}

