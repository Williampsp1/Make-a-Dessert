//
//  DessertDetailViewModel.swift
//  Make a Dessert
//
//  Created by William on 5/1/23.
//

import Foundation

class DessertDetailViewModel: ObservableObject {
    @Published var detailInfo: DessertDetailInformation?
    @Published var errorOccured: Bool = false
    var errorMessage = ""
    private let dessertProvider: DessertProviding
    
    init(dessertProvider: DessertProviding) {
        self.dessertProvider = dessertProvider
    }
    
    @MainActor @discardableResult
    func getDessertDetails(id: String) -> Task<Void, Never> {
        let task = Task {
            do {
                detailInfo = try await dessertProvider.getDessertDetail(id: id)
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
