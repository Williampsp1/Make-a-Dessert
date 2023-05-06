//
//  Make_a_DessertTests.swift
//  Make a DessertTests
//
//  Created by William on 5/1/23.
//

import XCTest

final class DessertListViewModelTests: XCTestCase {
    
    func testGetDessertMeals() async {
        let mockDessertMeals = [DessertListMealInfo(strMeal: "Apple Frangipan Tart", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52768"), DessertListMealInfo(strMeal: "Blackberry Fool", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52891")]
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProvider())
        let task = await viewModel.getDessertMeals()
        
        await task.value
        
        XCTAssertEqual(mockDessertMeals, viewModel.dessertListMeals)
        XCTAssert(viewModel.errorMessage.isEmpty)
        XCTAssertFalse(viewModel.errorOccured)
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
