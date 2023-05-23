//
//  Make_a_DessertTests.swift
//  Make a DessertTests
//
//  Created by William on 5/1/23.
//

import XCTest

final class DessertListViewModelTests: XCTestCase {
    
    private let mockMeal = DessertListMealInfo(strMeal: "Apple Frangipan Tart", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52768")
    private let mockMeal2 = DessertListMealInfo(strMeal: "Blackberry Fool", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52891")
    
    func testGetDessertMeals() async {
        let mockDessertMeals = [mockMeal, mockMeal2]
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProvider())
        let task = await viewModel.getDessertMeals()
        
        await task.value
        
        XCTAssertEqual(mockDessertMeals, viewModel.dessertListMeals)
        XCTAssert(viewModel.errorMessage.isEmpty)
        XCTAssertFalse(viewModel.errorOccured)
    }
    
    func testAddFavoriteId() {
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProvider())
        viewModel.favoriteIds = []
        XCTAssertEqual(viewModel.favoriteIds.count, 0)
        
        viewModel.addOrRemove(mockMeal.id)
        XCTAssertEqual(viewModel.favoriteIds[0], mockMeal.id)
        viewModel.addOrRemove(mockMeal2.id)
        XCTAssertEqual(viewModel.favoriteIds[1], mockMeal2.id)
    }
    
    func testLoadFavoriteIDs() {
        var viewModel: DessertListViewModel? = DessertListViewModel(dessertProvider: MockDessertProvider())
        viewModel?.favoriteIds = []
        viewModel?.addOrRemove("2") // Adds it to user defaults
        viewModel = nil
        let viewModel2 = DessertListViewModel(dessertProvider: MockDessertProvider())
        XCTAssertEqual(viewModel2.favoriteIds[0], "2")
    }
    
    func testRemoveFavoriteID() async {
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProvider())
        viewModel.favoriteIds = []
        XCTAssertEqual(viewModel.favoriteIds.count, 0)
        
        viewModel.addOrRemove(mockMeal.id)
        XCTAssertEqual(viewModel.favoriteIds[0], mockMeal.id)
        viewModel.addOrRemove(mockMeal.id)
        XCTAssertEqual(viewModel.favoriteIds.count, 0)
    }
    
    func testFetchFavorites() async {
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProvider())
        viewModel.favoriteIds = ["52768"] // Cache
        let task = await viewModel.getDessertMeals()
        await task.value
                
        viewModel.fetchFavorites()
        XCTAssertEqual(viewModel.favoriteMeals.count, 1)
        XCTAssertEqual(viewModel.favoriteMeals[0], mockMeal)
    }
    
    func testDessertMealsInvalidURL() async {
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProviderInvalidURL())
        let task = await viewModel.getDessertMeals()
        
        await task.value
        
        XCTAssertEqual(DessertErrors.invalidURL.localizedDescription, viewModel.errorMessage)
        XCTAssert(viewModel.dessertListMeals.isEmpty)
        XCTAssertTrue(viewModel.errorOccured)
    }
    
    func testDessertMealsNetworkError() async {
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProviderNetworkError())
        let task = await viewModel.getDessertMeals()
        
        await task.value
        
        XCTAssertEqual(DessertErrors.networkError.localizedDescription, viewModel.errorMessage)
        XCTAssert(viewModel.dessertListMeals.isEmpty)
        XCTAssertTrue(viewModel.errorOccured)
    }
    
    func testDessertMealsDecodingError() async {
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProviderDecodingError())
        let task = await viewModel.getDessertMeals()
        
        await task.value
        
        XCTAssertEqual(DessertErrors.decodingError.localizedDescription, viewModel.errorMessage)
        XCTAssert(viewModel.dessertListMeals.isEmpty)
        XCTAssertTrue(viewModel.errorOccured)
    }
}
