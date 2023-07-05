//
//  DessertListViewModel.swift
//  Make a Dessert
//
//  Created by William on 5/1/23.
//

import Foundation

class DessertListViewModel: ObservableObject {
    @Published var dessertListMeals: [DessertListMealInfo] = []
    @Published var loadingState: LoadingState = .loading
    var errorMessage = ""
    private let dessertProvider: DessertProviding
    
    enum LoadingState {
        case error
        case loading
        case loaded
    }
    
    init(dessertProvider: DessertProviding = DessertProvider()) {
        self.dessertProvider = dessertProvider
    }
    
    @MainActor @discardableResult
    func getDessertMeals() -> Task<Void, Never> {
        let task = Task {
            do {
                dessertListMeals = try await dessertProvider.getDesserts()
                loadingState = .loaded
            } catch let error {
                loadingState = .error
                errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
        return task
    }
}
