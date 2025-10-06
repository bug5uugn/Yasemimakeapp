import SwiftUI

@available(iOS 14.0, *)
struct NutritionInfoAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var store: RecipeDataStore
    
    @State private var calories = ""
    @State private var fatGrams = ""
    @State private var carbsGrams = ""
    @State private var proteinGrams = ""
    @State private var fiberGrams = ""
    @State private var sugarGrams = ""
    @State private var sodiumMg = ""
    @State private var cholesterolMg = ""
    @State private var potassiumMg = ""
    @State private var vitaminA = ""
    @State private var vitaminC = ""
    @State private var vitaminD = ""
    @State private var calciumMg = ""
    @State private var ironMg = ""
    @State private var transFat = ""
    @State private var saturatedFat = ""
    @State private var unsaturatedFat = ""
    @State private var omega3 = ""
    @State private var omega6 = ""
    @State private var waterContent = ""
    @State private var alcoholContent = ""
    @State private var caffeineMg = ""
    @State private var servingSize = ""
    @State private var servingsPerContainer = ""
    @State private var allergens = ""
    @State private var dietType = ""
    @State private var isGlutenFree = false
    @State private var isVegan = false
    @State private var isVegetarian = false
    @State private var isOrganic = false
    @State private var region = ""
    @State private var certification = ""
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isSuccess = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    NutritionInfoAddHeaderView()
                    
                    LazyVStack(spacing: 20) {
                        NutritionInfoAddSectionHeaderView(title: "Basic Nutrition", icon: "flame.fill", color: .orange)
                        
                        VStack(spacing: 16) {
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Calories", text: $calories, icon: "flame", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Fat (g)", text: $fatGrams, icon: "drop.fill", keyboardType: .numberPad)
                            }
                            
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Carbs (g)", text: $carbsGrams, icon: "leaf.fill", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Protein (g)", text: $proteinGrams, icon: "bolt.fill", keyboardType: .numberPad)
                            }
                            
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Fiber (g)", text: $fiberGrams, icon: "tree.fill", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Sugar (g)", text: $sugarGrams, icon: "cube.fill", keyboardType: .numberPad)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        NutritionInfoAddSectionHeaderView(title: "Minerals & Vitamins", icon: "pills.fill", color: .green)
                        
                        VStack(spacing: 16) {
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Sodium (mg)", text: $sodiumMg, icon: "drop.triangle.fill", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Cholesterol (mg)", text: $cholesterolMg, icon: "heart.fill", keyboardType: .numberPad)
                            }
                            
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Potassium (mg)", text: $potassiumMg, icon: "bolt.circle.fill", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Calcium (mg)", text: $calciumMg, icon: "bone", keyboardType: .numberPad)
                            }
                            
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Vitamin A (%)", text: $vitaminA, icon: "eye.fill", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Vitamin C (%)", text: $vitaminC, icon: "c.circle.fill", keyboardType: .numberPad)
                            }
                            
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Vitamin D (%)", text: $vitaminD, icon: "sun.max.fill", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Iron (mg)", text: $ironMg, icon: "shield.fill", keyboardType: .numberPad)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        NutritionInfoAddSectionHeaderView(title: "Fat Details", icon: "drop.circle.fill", color: .blue)
                        
                        VStack(spacing: 16) {
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Trans Fat (g)", text: $transFat, icon: "xmark.circle.fill", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Saturated Fat (g)", text: $saturatedFat, icon: "minus.circle.fill", keyboardType: .numberPad)
                            }
                            
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Unsaturated Fat (g)", text: $unsaturatedFat, icon: "plus.circle.fill", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Omega-3 (g)", text: $omega3, icon: "wave.3.right", keyboardType: .numberPad)
                            }
                            
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Omega-6 (g)", text: $omega6, icon: "wave.3.left", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Water (%)", text: $waterContent, icon: "drop.fill", keyboardType: .numberPad)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        NutritionInfoAddSectionHeaderView(title: "Additional Info", icon: "info.circle.fill", color: .purple)
                        
                        VStack(spacing: 16) {
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Alcohol (%)", text: $alcoholContent, icon: "wineglass.fill", keyboardType: .numberPad)
                                NutritionInfoAddFieldView(title: "Caffeine (mg)", text: $caffeineMg, icon: "cup.and.saucer.fill", keyboardType: .numberPad)
                            }
                            
                            HStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Serving Size", text: $servingSize, icon: "scalemass.fill", keyboardType: .default)
                                NutritionInfoAddFieldView(title: "Servings/Container", text: $servingsPerContainer, icon: "number.circle.fill", keyboardType: .numberPad)
                            }
                            
                            VStack(spacing: 12) {
                                NutritionInfoAddFieldView(title: "Allergens (comma separated)", text: $allergens, icon: "exclamationmark.triangle.fill", keyboardType: .default)
                                NutritionInfoAddFieldView(title: "Diet Type", text: $dietType, icon: "leaf.circle.fill", keyboardType: .default)
                                NutritionInfoAddFieldView(title: "Region", text: $region, icon: "globe", keyboardType: .default)
                                NutritionInfoAddFieldView(title: "Certification", text: $certification, icon: "checkmark.seal.fill", keyboardType: .default)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        NutritionInfoAddSectionHeaderView(title: "Diet Preferences", icon: "checkmark.circle.fill", color: .orange)
                        
                        VStack(spacing: 12) {
                            NutritionInfoAddToggleView(title: "Gluten Free", isOn: $isGlutenFree, icon: "g.circle.fill")
                            NutritionInfoAddToggleView(title: "Vegan", isOn: $isVegan, icon: "leaf.fill")
                            NutritionInfoAddToggleView(title: "Vegetarian", isOn: $isVegetarian, icon: "carrot.fill")
                            NutritionInfoAddToggleView(title: "Organic", isOn: $isOrganic, icon: "seal.fill")
                        }
                        .padding(.horizontal, 20)
                        
                        NutritionInfoAddSubmitButtonView(action: validateAndSave)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 30)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Add Nutrition Info", displayMode: .large)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.red),
                trailing: Button("Save") {
                    validateAndSave()
                }
                .foregroundColor(.blue)
            )
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(isSuccess ? "Success" : "Validation Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if isSuccess {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
    
    private func validateAndSave() {
        var errors: [String] = []
        
        // Validate required numeric fields
        if calories.isEmpty || Int(calories) == nil { errors.append("Calories is required") }
        if fatGrams.isEmpty || Int(fatGrams) == nil { errors.append("Fat grams is required") }
        if carbsGrams.isEmpty || Int(carbsGrams) == nil { errors.append("Carbs grams is required") }
        if proteinGrams.isEmpty || Int(proteinGrams) == nil { errors.append("Protein grams is required") }
        if fiberGrams.isEmpty || Int(fiberGrams) == nil { errors.append("Fiber grams is required") }
        if sugarGrams.isEmpty || Int(sugarGrams) == nil { errors.append("Sugar grams is required") }
        if sodiumMg.isEmpty || Int(sodiumMg) == nil { errors.append("Sodium mg is required") }
        if cholesterolMg.isEmpty || Int(cholesterolMg) == nil { errors.append("Cholesterol mg is required") }
        if potassiumMg.isEmpty || Int(potassiumMg) == nil { errors.append("Potassium mg is required") }
        if vitaminA.isEmpty || Int(vitaminA) == nil { errors.append("Vitamin A is required") }
        if vitaminC.isEmpty || Int(vitaminC) == nil { errors.append("Vitamin C is required") }
        if vitaminD.isEmpty || Int(vitaminD) == nil { errors.append("Vitamin D is required") }
        if calciumMg.isEmpty || Int(calciumMg) == nil { errors.append("Calcium mg is required") }
        if ironMg.isEmpty || Int(ironMg) == nil { errors.append("Iron mg is required") }
        if transFat.isEmpty || Int(transFat) == nil { errors.append("Trans fat is required") }
        
        // Validate required text fields
        if servingSize.isEmpty { errors.append("Serving size is required") }
        if servingsPerContainer.isEmpty || Int(servingsPerContainer) == nil { errors.append("Servings per container is required") }
        if dietType.isEmpty { errors.append("Diet type is required") }
        if region.isEmpty { errors.append("Region is required") }
        
        if !errors.isEmpty {
            alertMessage = errors.joined(separator: "\n• ")
            isSuccess = false
            showingAlert = true
            return
        }
        
        // Create new nutrition info
        let newInfo = NutritionInfo(
            calories: Int(calories) ?? 0,
            fatGrams: Int(fatGrams) ?? 0,
            carbsGrams: Int(carbsGrams) ?? 0,
            proteinGrams: Int(proteinGrams) ?? 0,
            fiberGrams: Int(fiberGrams) ?? 0,
            sugarGrams: Int(sugarGrams) ?? 0,
            sodiumMg: Int(sodiumMg) ?? 0,
            cholesterolMg: Int(cholesterolMg) ?? 0,
            potassiumMg: Int(potassiumMg) ?? 0,
            vitaminA: Int(vitaminA) ?? 0,
            vitaminC: Int(vitaminC) ?? 0,
            vitaminD: Int(vitaminD) ?? 0,
            calciumMg: Int(calciumMg) ?? 0,
            ironMg: Int(ironMg) ?? 0,
            transFat: Int(transFat) ?? 0,
            saturatedFat: Int(saturatedFat) ?? 0,
            unsaturatedFat: Int(unsaturatedFat) ?? 0,
            omega3: Int(omega3) ?? 0,
            omega6: Int(omega6) ?? 0,
            waterContent: Int(waterContent) ?? 0,
            alcoholContent: Int(alcoholContent) ?? 0,
            caffeineMg: Int(caffeineMg) ?? 0,
            servingSize: servingSize,
            servingsPerContainer: Int(servingsPerContainer) ?? 0,
            dailyValuePercent: [],
            allergens: allergens.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) },
            dietType: dietType,
            isGlutenFree: isGlutenFree,
            isVegan: isVegan,
            isVegetarian: isVegetarian,
            isOrganic: isOrganic,
            region: region,
            certification: certification,
            calculatedAt: Date(),
            verified: false
        )
        
        store.addNutritionInfo(newInfo)
        
        alertMessage = "Nutrition information has been successfully added!"
        isSuccess = true
        showingAlert = true
    }
}
