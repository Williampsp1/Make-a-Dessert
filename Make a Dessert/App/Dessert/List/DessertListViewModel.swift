//
//  DessertListViewModel.swift
//  Make a Dessert
//
//  Created by William on 5/1/23.
//

import Foundation

class DessertListViewModel: ObservableObject {
    @Published var dessertListMeals: [DessertListMealInfo] = []
    @Published var errorOccured: Bool = false
    @Published var favoriteIds = (UserDefaults.standard.array(forKey: "favorites") as? [String] ?? [])
    @Published var favoriteMeals: [DessertListMealInfo] = []
    var errorMessage = ""
    private let dessertProvider: DessertProviding
    
    init(dessertProvider: DessertProviding) {
        self.dessertProvider = dessertProvider
    }
    
    @MainActor @discardableResult
    func getDessertMeals() -> Task<Void, Never> {
        let task = Task {
            do {
                dessertListMeals = try await dessertProvider.getDesserts()
                errorOccured = false
            } catch let error {
                errorOccured = true
                errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
        return task
    }
    
    func addOrRemove(_ mealId: String) {
        if favoriteIds.contains(mealId) {
            favoriteIds.removeAll { $0 == mealId }
        } else {
            favoriteIds.append(mealId)
        }
        UserDefaults.standard.set(self.favoriteIds, forKey: "favorites")
    }
    
    func fetchFavorites() {
        favoriteMeals = dessertListMeals.filter { meal in favoriteIds.contains { meal.id == $0 }}
    }
}
