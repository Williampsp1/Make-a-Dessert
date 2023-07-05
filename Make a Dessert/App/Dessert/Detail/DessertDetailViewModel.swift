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
    func getDessertDetails(id: String) -> Task<Void, Never> {
        let task = Task {
            do {
                detailInfo = try await dessertProvider.getDessertDetail(id: id)
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
