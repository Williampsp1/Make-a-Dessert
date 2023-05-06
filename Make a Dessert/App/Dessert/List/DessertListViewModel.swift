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
}
