//
//  FavoritesService.swift
//  Make a Dessert
//
//  Created by William on 6/17/23.
//

import Foundation

class FavoritesService: ObservableObject {
    @Published var favoriteIds = (UserDefaults.standard.array(forKey: "favorites") as? [String] ?? [])
    @Published var favoriteMeals: [DessertListMealInfo] = []
    @Published var loadingState: LoadingState = .loading
    private var dessertListMeals: [DessertListMealInfo] = []
    private let dessertProvider: DessertProviding
    var errorMessage = ""
    
    enum LoadingState {
        case error
        case loading
        case loaded
        case noFavorites
    }
    
    init(dessertProvider: DessertProviding = DessertProvider()) {
        self.dessertProvider = dessertProvider
    }
    
    func addOrRemove(_ mealId: String) {
        if let index = favoriteIds.firstIndex(where: { $0 == mealId }) {
            favoriteIds.remove(at: index)
        } else {
            favoriteIds.append(mealId)
        }
        UserDefaults.standard.set(self.favoriteIds, forKey: "favorites")
        getFavorites()
    }
    
    @MainActor @discardableResult
    func fetchFavorites() -> Task<Void, Never> {
        let task = Task {
            do {
                dessertListMeals = try await dessertProvider.getDesserts()
                getFavorites()
                if favoriteMeals.isEmpty {
                    loadingState = .noFavorites
                } else {
                    loadingState = .loaded
                }
            } catch let error {
                loadingState = .error
                errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
        return task
    }
    
    private func getFavorites() {
        favoriteMeals = dessertListMeals.filter { meal in favoriteIds.contains { meal.id == $0 }}
    }
}
