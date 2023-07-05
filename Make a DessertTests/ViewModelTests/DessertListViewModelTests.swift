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
    }
    
    func testDessertMealsInvalidURL() async {
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProviderInvalidURL())
        let task = await viewModel.getDessertMeals()
        
        await task.value
        
        XCTAssertEqual(DessertErrors.invalidURL.localizedDescription, viewModel.errorMessage)
        XCTAssert(viewModel.dessertListMeals.isEmpty)
    }
    
    func testDessertMealsNetworkError() async {
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProviderNetworkError())
        let task = await viewModel.getDessertMeals()
        
        await task.value
        
        XCTAssertEqual(DessertErrors.networkError.localizedDescription, viewModel.errorMessage)
        XCTAssert(viewModel.dessertListMeals.isEmpty)
    }
    
    func testDessertMealsDecodingError() async {
        let viewModel = DessertListViewModel(dessertProvider: MockDessertProviderDecodingError())
        let task = await viewModel.getDessertMeals()
        
        await task.value
        
        XCTAssertEqual(DessertErrors.decodingError.localizedDescription, viewModel.errorMessage)
        XCTAssert(viewModel.dessertListMeals.isEmpty)
    }
}
