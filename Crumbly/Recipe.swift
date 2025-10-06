import Foundation

struct Recipe: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var ingredients: [UUID]
    var steps: [UUID]
    var tags: [String]
    var servings: Int
    var category: String
    var cuisine: String
    var difficulty: String
    var prepMinutes: Int
    var cookMinutes: Int
    var totalMinutes: Int
    var createdAt: Date
    var updatedAt: Date
    var author: String
    var notes: String
    var calories: Int
    var rating: Int
    var isFavorite: Bool
    var imageIDs: [UUID]
    var videoURL: String
    var source: String
    var allergens: [String]
    var nutritionSummary: String
    var utensilIDs: [UUID]
    var isDraft: Bool
    var isPublished: Bool
    var portionSize: String
    var costEstimate: Double
    var keywords: [String]
    var season: String
    var region: String
    var storageInstructions: String
    var tips: [String]
    var variations: [String]
}

struct Ingredient: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var amount: String
    var unit: String
    var notes: String
    var category: String
    var isOptional: Bool
    var allergens: [String]
    var calories: Int
    var protein: Int
    var carbs: Int
    var fat: Int
    var fiber: Int
    var sugar: Int
    var sodium: Int
    var source: String
    var brand: String
    var cost: Double
    var isAvailable: Bool
    var purchaseDate: Date
    var expiryDate: Date
    var storageLocation: String
    var substituteOptions: [String]
    var color: String
    var texture: String
    var origin: String
    var organic: Bool
    var glutenFree: Bool
    var vegan: Bool
    var vegetarian: Bool
    var halal: Bool
    var kosher: Bool
    var addedAt: Date
    var updatedAt: Date
}

struct RecipeStep: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var order: Int
    var instruction: String
    var estimatedMinutes: Int
    var imageID: UUID?
    var videoURL: String
    var timerMinutes: Int
    var requiredTools: [String]
    var createdAt: Date
    var updatedAt: Date
    var tip: String
    var difficulty: String
    var note: String
    var isOptional: Bool
    var ingredientsUsed: [UUID]
    var caloriesBurned: Int
    var restMinutes: Int
    var repeatCount: Int
    var backgroundMusic: String
    var soundEffect: String
    var priority: Int
    var isCritical: Bool
    var successRate: Double
    var safetyNotes: String
    var commonMistakes: [String]
    var alternatives: [String]
    var region: String
    var style: String
    var toolHints: [String]
    var skillLevel: String
    var isAutomatable: Bool
    var linkedStepIDs: [UUID]
    var completed: Bool
}

struct ShoppingList: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var title: String
    var items: [String]
    var createdAt: Date
    var updatedAt: Date
    var owner: String
    var isShared: Bool
    var tags: [String]
    var notes: String
    var estimatedCost: Double
    var currency: String
    var priority: Int
    var reminders: [Date]
    var completedItems: [String]
    var pendingItems: [String]
    var category: String
    var store: String
    var aisleHints: [String]
    var favorite: Bool
    var archived: Bool
    var recurring: Bool
    var recurrenceRule: String
    var lastUsed: Date
    var colorHex: String
    var iconName: String
    var sharedWith: [String]
    var exported: Bool
    var imported: Bool
    var deviceID: String
    var backupFile: String
    var syncStatus: String
    var locationHint: String
    var listType: String
    var version: Int
    var draft: Bool
}

struct NutritionInfo: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var calories: Int
    var fatGrams: Int
    var carbsGrams: Int
    var proteinGrams: Int
    var fiberGrams: Int
    var sugarGrams: Int
    var sodiumMg: Int
    var cholesterolMg: Int
    var potassiumMg: Int
    var vitaminA: Int
    var vitaminC: Int
    var vitaminD: Int
    var calciumMg: Int
    var ironMg: Int
    var transFat: Int
    var saturatedFat: Int
    var unsaturatedFat: Int
    var omega3: Int
    var omega6: Int
    var waterContent: Int
    var alcoholContent: Int
    var caffeineMg: Int
    var servingSize: String
    var servingsPerContainer: Int
    var dailyValuePercent: [String]
    var allergens: [String]
    var dietType: String
    var isGlutenFree: Bool
    var isVegan: Bool
    var isVegetarian: Bool
    var isOrganic: Bool
    var region: String
    var certification: String
    var calculatedAt: Date
    var verified: Bool
}

struct RecipeTimer: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var stepID: UUID
    var durationMinutes: Int
    var note: String
    var createdAt: Date
    var updatedAt: Date
    var isActive: Bool
    var isRepeating: Bool
    var repeatInterval: Int
    var soundName: String
    var vibration: Bool
    var autoStart: Bool
    var autoStop: Bool
    var warningMinutes: Int
    var snoozeEnabled: Bool
    var snoozeDuration: Int
    var linkedTimers: [UUID]
    var label: String
    var colorHex: String
    var priority: Int
    var completed: Bool
    var cancelled: Bool
    var paused: Bool
    var resumedAt: Date?
    var pausedAt: Date?
    var finishedAt: Date?
    var nextTrigger: Date?
    var history: [Date]
    var deviceID: String
    var userID: String
    var backupStatus: String
    var reminderNote: String
    var timerType: String
    var accuracyLevel: String
    var maxDuration: Int
    var minDuration: Int
}
import Foundation
import Combine

/// Data manager for recipes app
class RecipeDataStore: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var ingredients: [Ingredient] = []
    @Published var steps: [RecipeStep] = []
    @Published var shoppingLists: [ShoppingList] = []
    @Published var nutritionInfos: [NutritionInfo] = []
    @Published var timers: [RecipeTimer] = []
    
    private let defaults = UserDefaults.standard
    
    private enum Keys: String {
        case recipes, ingredients, steps, shoppingLists, nutritionInfos, timers
    }
    
    init() {
        loadData()
        if recipes.isEmpty {
            loadDummyData()
            saveData()
        }
    }
    
    // MARK: - Add Functions
    func addRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
        saveData()
    }
    func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
        saveData()
    }
    func addStep(_ step: RecipeStep) {
        steps.append(step)
        saveData()
    }
    func addShoppingList(_ list: ShoppingList) {
        shoppingLists.append(list)
        saveData()
    }
    func addNutritionInfo(_ info: NutritionInfo) {
        nutritionInfos.append(info)
        saveData()
    }
    func addTimer(_ timer: RecipeTimer) {
        timers.append(timer)
        saveData()
    }
    
    // MARK: - Delete Functions
    func deleteRecipe(_ recipe: Recipe) {
        recipes.removeAll { $0.id == recipe.id }
        saveData()
    }
    func deleteIngredient(_ ingredient: Ingredient) {
        ingredients.removeAll { $0.id == ingredient.id }
        saveData()
    }
    func deleteStep(_ step: RecipeStep) {
        steps.removeAll { $0.id == step.id }
        saveData()
    }
    func deleteShoppingList(_ list: ShoppingList) {
        shoppingLists.removeAll { $0.id == list.id }
        saveData()
    }
    func deleteNutritionInfo(_ info: NutritionInfo) {
        nutritionInfos.removeAll { $0.id == info.id }
        saveData()
    }
    func deleteTimer(_ timer: RecipeTimer) {
        timers.removeAll { $0.id == timer.id }
        saveData()
    }
    
    // MARK: - Save / Load
    private func saveData() {
        save(recipes, key: .recipes)
        save(ingredients, key: .ingredients)
        save(steps, key: .steps)
        save(shoppingLists, key: .shoppingLists)
        save(nutritionInfos, key: .nutritionInfos)
        save(timers, key: .timers)
    }
    
    private func loadData() {
        recipes = load(key: .recipes)
        ingredients = load(key: .ingredients)
        steps = load(key: .steps)
        shoppingLists = load(key: .shoppingLists)
        nutritionInfos = load(key: .nutritionInfos)
        timers = load(key: .timers)
    }
    
    private func save<T: Codable>(_ data: [T], key: Keys) {
        if let encoded = try? JSONEncoder().encode(data) {
            defaults.set(encoded, forKey: key.rawValue)
        }
    }
    
    private func load<T: Codable>(key: Keys) -> [T] {
        guard let saved = defaults.data(forKey: key.rawValue),
              let decoded = try? JSONDecoder().decode([T].self, from: saved) else {
            return []
        }
        return decoded
    }
    
    // MARK: - Dummy Data
    func loadDummyData() {
        let sampleIngredient = Ingredient(
            name: "Flour",
            amount: "2",
            unit: "cups",
            notes: "All-purpose",
            category: "Baking",
            isOptional: false,
            allergens: ["Gluten"],
            calories: 455,
            protein: 13,
            carbs: 95,
            fat: 1,
            fiber: 3,
            sugar: 0,
            sodium: 2,
            source: "Local Market",
            brand: "Generic",
            cost: 1.5,
            isAvailable: true,
            purchaseDate: Date(),
            expiryDate: Date().addingTimeInterval(60*60*24*90),
            storageLocation: "Pantry",
            substituteOptions: ["Almond Flour"],
            color: "White",
            texture: "Powder",
            origin: "USA",
            organic: false,
            glutenFree: false,
            vegan: true,
            vegetarian: true,
            halal: true,
            kosher: true,
            addedAt: Date(),
            updatedAt: Date()
        )
        
        let sampleStep = RecipeStep(
            order: 1,
            instruction: "Mix flour and sugar together.",
            estimatedMinutes: 5,
            imageID: nil,
            videoURL: "",
            timerMinutes: 0,
            requiredTools: ["Bowl", "Spoon"],
            createdAt: Date(),
            updatedAt: Date(),
            tip: "Use a wooden spoon.",
            difficulty: "Easy",
            note: "Basic prep",
            isOptional: false,
            ingredientsUsed: [sampleIngredient.id],
            caloriesBurned: 10,
            restMinutes: 0,
            repeatCount: 1,
            backgroundMusic: "",
            soundEffect: "",
            priority: 1,
            isCritical: true,
            successRate: 100,
            safetyNotes: "",
            commonMistakes: [],
            alternatives: [],
            region: "Global",
            style: "Traditional",
            toolHints: [],
            skillLevel: "Beginner",
            isAutomatable: false,
            linkedStepIDs: [],
            completed: false
        )
        
        let sampleRecipe = Recipe(
            title: "Chocolate Chip Cookies",
            description: "Classic chewy chocolate chip cookies.",
            ingredients: [sampleIngredient.id],
            steps: [sampleStep.id],
            tags: ["Dessert", "Cookies"],
            servings: 12,
            category: "Dessert",
            cuisine: "American",
            difficulty: "Easy",
            prepMinutes: 15,
            cookMinutes: 12,
            totalMinutes: 27,
            createdAt: Date(),
            updatedAt: Date(),
            author: "Chef Demo",
            notes: "Family favorite",
            calories: 200,
            rating: 5,
            isFavorite: true,
            imageIDs: [],
            videoURL: "",
            source: "Homemade",
            allergens: ["Gluten", "Eggs", "Dairy"],
            nutritionSummary: "200 cal per cookie",
            utensilIDs: [],
            isDraft: false,
            isPublished: true,
            portionSize: "1 cookie",
            costEstimate: 5.0,
            keywords: ["chocolate", "cookie"],
            season: "All",
            region: "Global",
            storageInstructions: "Store in airtight jar",
            tips: ["Chill dough before baking"],
            variations: ["Add walnuts"]
        )
        
        let sampleList = ShoppingList(
            title: "Cookie Ingredients",
            items: ["Flour", "Sugar", "Chocolate Chips"],
            createdAt: Date(),
            updatedAt: Date(),
            owner: "User",
            isShared: false,
            tags: ["Cookies"],
            notes: "",
            estimatedCost: 10.0,
            currency: "USD",
            priority: 1,
            reminders: [],
            completedItems: [],
            pendingItems: ["Flour", "Sugar"],
            category: "Groceries",
            store: "Local Market",
            aisleHints: ["Baking Aisle"],
            favorite: true,
            archived: false,
            recurring: false,
            recurrenceRule: "",
            lastUsed: Date(),
            colorHex: "#FFD700",
            iconName: "cart",
            sharedWith: [],
            exported: false,
            imported: false,
            deviceID: "Device001",
            backupFile: "",
            syncStatus: "Local",
            locationHint: "Pantry",
            listType: "Grocery",
            version: 1,
            draft: false
        )
        
        let sampleNutrition = NutritionInfo(
            calories: 200,
            fatGrams: 8,
            carbsGrams: 30,
            proteinGrams: 3,
            fiberGrams: 1,
            sugarGrams: 18,
            sodiumMg: 150,
            cholesterolMg: 15,
            potassiumMg: 50,
            vitaminA: 0,
            vitaminC: 0,
            vitaminD: 0,
            calciumMg: 20,
            ironMg: 1,
            transFat: 0,
            saturatedFat: 5,
            unsaturatedFat: 3,
            omega3: 0,
            omega6: 0,
            waterContent: 5,
            alcoholContent: 0,
            caffeineMg: 2,
            servingSize: "1 cookie",
            servingsPerContainer: 12,
            dailyValuePercent: ["10% fat", "5% carbs"],
            allergens: ["Gluten", "Eggs"],
            dietType: "Vegetarian",
            isGlutenFree: false,
            isVegan: false,
            isVegetarian: true,
            isOrganic: false,
            region: "Global",
            certification: "None",
            calculatedAt: Date(),
            verified: true
        )
        
        let sampleTimer = RecipeTimer(
            stepID: sampleStep.id,
            durationMinutes: 12,
            note: "Bake until golden brown",
            createdAt: Date(),
            updatedAt: Date(),
            isActive: false,
            isRepeating: false,
            repeatInterval: 0,
            soundName: "Bell",
            vibration: true,
            autoStart: false,
            autoStop: true,
            warningMinutes: 2,
            snoozeEnabled: false,
            snoozeDuration: 0,
            linkedTimers: [],
            label: "Bake Timer",
            colorHex: "#FF4500",
            priority: 1,
            completed: false,
            cancelled: false,
            paused: false,
            resumedAt: nil,
            pausedAt: nil,
            finishedAt: nil,
            nextTrigger: nil,
            history: [],
            deviceID: "Device001",
            userID: "User001",
            backupStatus: "Local",
            reminderNote: "Check oven",
            timerType: "Oven",
            accuracyLevel: "High",
            maxDuration: 60,
            minDuration: 1
        )
        
        ingredients = [sampleIngredient]
        steps = [sampleStep]
        recipes = [sampleRecipe]
        shoppingLists = [sampleList]
        nutritionInfos = [sampleNutrition]
        timers = [sampleTimer]
    }
}
