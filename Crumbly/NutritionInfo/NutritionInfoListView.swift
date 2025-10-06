import SwiftUI

@available(iOS 14.0, *)
struct NutritionInfoListView: View {
    @ObservedObject var store: RecipeDataStore
    @State private var searchText = ""
    @State private var showingAddView = false
    
    var filteredNutritionInfos: [NutritionInfo] {
        if searchText.isEmpty {
            return store.nutritionInfos
        } else {
            return store.nutritionInfos.filter { info in
                info.dietType.localizedCaseInsensitiveContains(searchText) ||
                info.region.localizedCaseInsensitiveContains(searchText) ||
                info.allergens.joined().localizedCaseInsensitiveContains(searchText) ||
                info.certification.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
            VStack(spacing: 0) {
                NutritionInfoSearchBarView(searchText: $searchText)
                
                if filteredNutritionInfos.isEmpty {
                    NutritionInfoNoDataView()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredNutritionInfos) { info in
                                NavigationLink(destination: NutritionInfoDetailView(nutritionInfo: info)) {
                                    NutritionInfoListRowView(nutritionInfo: info)
                                        .onLongPressGesture {
                                            store.deleteNutritionInfo(info)
                                        }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Nutrition Info", displayMode: .large)
            .navigationBarItems(
                trailing: Button(action: {
                    showingAddView = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.blue)
                }
            )
        
        .sheet(isPresented: $showingAddView) {
            NutritionInfoAddView(store: store)
        }
    }
}
