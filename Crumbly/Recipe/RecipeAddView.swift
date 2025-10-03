import SwiftUI

@available(iOS 14.0, *)
struct RecipeAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var dataStore: RecipeDataStore
    
    @State private var title = ""
    @State private var description = ""
    @State private var category = ""
    @State private var cuisine = ""
    @State private var difficulty = "Easy"
    @State private var servings = 4
    @State private var prepMinutes = 15
    @State private var cookMinutes = 30
    @State private var author = ""
    @State private var notes = ""
    @State private var calories = 200
    @State private var rating = 5
    @State private var source = ""
    @State private var portionSize = ""
    @State private var costEstimate = 10.0
    @State private var season = "Year Round"
    @State private var region = ""
    @State private var storageInstructions = ""
    @State private var nutritionSummary = ""
    @State private var videoURL = ""
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isSuccess = false
    
    let difficulties = ["Easy", "Intermediate", "Advanced", "Expert"]
    let seasons = ["Spring", "Summer", "Fall", "Winter", "Year Round"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Header Section
                    RecipeAddHeaderView()
                    
                    // Form Content
                    LazyVStack(spacing: 24) {
                        // Basic Information Section
                        RecipeAddSectionHeaderView(
                            title: "Basic Information",
                            icon: "info.circle.fill",
                            color: .blue
                        )
                        
                        VStack(spacing: 16) {
                            RecipeAddFieldView(
                                title: "Recipe Title",
                                text: $title,
                                icon: "text.cursor",
                                placeholder: "Enter recipe name"
                            )
                            
                            RecipeAddTextEditorView(
                                title: "Description",
                                text: $description,
                                icon: "doc.text.fill",
                                placeholder: "Describe your recipe..."
                            )
                            
                            HStack(spacing: 12) {
                                RecipeAddFieldView(
                                    title: "Category",
                                    text: $category,
                                    icon: "folder.fill",
                                    placeholder: "e.g., Dessert"
                                )
                                
                                RecipeAddFieldView(
                                    title: "Cuisine",
                                    text: $cuisine,
                                    icon: "globe",
                                    placeholder: "e.g., Italian"
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Cooking Details Section
                        RecipeAddSectionHeaderView(
                            title: "Cooking Details",
                            icon: "timer",
                            color: .orange
                        )
                        
                        VStack(spacing: 16) {
                            HStack(spacing: 12) {
                                RecipeAddPickerView(
                                    title: "Difficulty",
                                    selection: $difficulty,
                                    options: difficulties,
                                    icon: "chart.bar.fill"
                                )
                                
                                RecipeAddStepperView(
                                    title: "Servings",
                                    value: $servings,
                                    icon: "person.2.fill",
                                    range: 1...20
                                )
                            }
                            
                            HStack(spacing: 12) {
                                RecipeAddStepperView(
                                    title: "Prep Time",
                                    value: $prepMinutes,
                                    icon: "clock.fill",
                                    range: 5...300,
                                    suffix: "min"
                                )
                                
                                RecipeAddStepperView(
                                    title: "Cook Time",
                                    value: $cookMinutes,
                                    icon: "flame.fill",
                                    range: 5...480,
                                    suffix: "min"
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Recipe Information Section
                        RecipeAddSectionHeaderView(
                            title: "Recipe Information",
                            icon: "book.fill",
                            color: .green
                        )
                        
                        VStack(spacing: 16) {
                            RecipeAddFieldView(
                                title: "Author",
                                text: $author,
                                icon: "person.fill",
                                placeholder: "Recipe creator"
                            )
                            
                            RecipeAddFieldView(
                                title: "Source",
                                text: $source,
                                icon: "link",
                                placeholder: "Where did you find this recipe?"
                            )
                            
                            RecipeAddTextEditorView(
                                title: "Notes",
                                text: $notes,
                                icon: "note.text",
                                placeholder: "Any special notes or tips..."
                            )
                        }
                        .padding(.horizontal, 20)
                        
                        // Nutrition & Details Section
                        RecipeAddSectionHeaderView(
                            title: "Nutrition & Details",
                            icon: "heart.fill",
                            color: .red
                        )
                        
                        VStack(spacing: 16) {
                            HStack(spacing: 12) {
                                RecipeAddStepperView(
                                    title: "Calories",
                                    value: $calories,
                                    icon: "flame",
                                    range: 50...2000,
                                    suffix: "cal"
                                )
                                
                                RecipeAddStepperView(
                                    title: "Rating",
                                    value: $rating,
                                    icon: "star.fill",
                                    range: 1...5
                                )
                            }
                            
                            RecipeAddFieldView(
                                title: "Portion Size",
                                text: $portionSize,
                                icon: "scalemass.fill",
                                placeholder: "e.g., 1 cup, 1 slice"
                            )
                            
                            RecipeAddSliderView(
                                title: "Cost Estimate",
                                value: $costEstimate,
                                icon: "dollarsign.circle.fill",
                                range: 1...100,
                                format: "$%.2f"
                            )
                        }
                        .padding(.horizontal, 20)
                        
                        // Additional Information Section
                        RecipeAddSectionHeaderView(
                            title: "Additional Information",
                            icon: "info.circle.fill",
                            color: .purple
                        )
                        
                        VStack(spacing: 16) {
                            HStack(spacing: 12) {
                                RecipeAddPickerView(
                                    title: "Season",
                                    selection: $season,
                                    options: seasons,
                                    icon: "leaf.fill"
                                )
                                
                                RecipeAddFieldView(
                                    title: "Region",
                                    text: $region,
                                    icon: "map.fill",
                                    placeholder: "Geographic origin"
                                )
                            }
                            
                            RecipeAddTextEditorView(
                                title: "Storage Instructions",
                                text: $storageInstructions,
                                icon: "archivebox.fill",
                                placeholder: "How to store this recipe..."
                            )
                            
                            RecipeAddTextEditorView(
                                title: "Nutrition Summary",
                                text: $nutritionSummary,
                                icon: "chart.pie.fill",
                                placeholder: "Brief nutrition overview..."
                            )
                            
                            RecipeAddFieldView(
                                title: "Video URL",
                                text: $videoURL,
                                icon: "video.fill",
                                placeholder: "Optional video tutorial link"
                            )
                        }
                        .padding(.horizontal, 20)
                        
                        // Save Button
                        RecipeAddSaveButtonView(action: saveRecipe)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 30)
                    }
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(isSuccess ? "Success!" : "Validation Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if isSuccess {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
    
    private func saveRecipe() {
        let errors = validateFields()
        
        if !errors.isEmpty {
            alertMessage = "Please fix the following issues:\n\n" + errors.joined(separator: "\n")
            isSuccess = false
            showingAlert = true
            return
        }
        
        let newRecipe = Recipe(
            title: title,
            description: description,
            ingredients: [],
            steps: [],
            tags: [],
            servings: servings,
            category: category,
            cuisine: cuisine,
            difficulty: difficulty,
            prepMinutes: prepMinutes,
            cookMinutes: cookMinutes,
            totalMinutes: prepMinutes + cookMinutes,
            createdAt: Date(),
            updatedAt: Date(),
            author: author,
            notes: notes,
            calories: calories,
            rating: rating,
            isFavorite: false,
            imageIDs: [],
            videoURL: videoURL,
            source: source,
            allergens: [],
            nutritionSummary: nutritionSummary,
            utensilIDs: [],
            isDraft: false,
            isPublished: true,
            portionSize: portionSize,
            costEstimate: costEstimate,
            keywords: [],
            season: season,
            region: region,
            storageInstructions: storageInstructions,
            tips: [],
            variations: []
        )
        
        dataStore.addRecipe(newRecipe)
        
        alertMessage = "Recipe '\(title)' has been successfully created!"
        isSuccess = true
        showingAlert = true
    }
    
    private func validateFields() -> [String] {
        var errors: [String] = []
        
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Recipe title is required")
        }
        
        if description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Description is required")
        }
        
        if category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Category is required")
        }
        
        if cuisine.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Cuisine is required")
        }
        
        if author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Author is required")
        }
        
        if source.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Source is required")
        }
        
        if portionSize.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Portion size is required")
        }
        
        if region.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Region is required")
        }
        
        if storageInstructions.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Storage instructions are required")
        }
        
        if nutritionSummary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("• Nutrition summary is required")
        }
        
        if servings < 1 {
            errors.append("• Servings must be at least 1")
        }
        
        if prepMinutes < 5 {
            errors.append("• Prep time must be at least 5 minutes")
        }
        
        if cookMinutes < 5 {
            errors.append("• Cook time must be at least 5 minutes")
        }
        
        if calories < 50 {
            errors.append("• Calories must be at least 50")
        }
        
        if costEstimate < 1 {
            errors.append("• Cost estimate must be at least $1.00")
        }
        
        return errors
    }
}
