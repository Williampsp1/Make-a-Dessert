//
//  DessertDetailViewModelTests.swift
//  Make a DessertTests
//
//  Created by William on 5/3/23.
//

import XCTest

final class DessertDetailViewModelTests: XCTestCase {
    
    func testGetDessertDetailsTest() async {
        let mockDessertDetailInfo = DessertDetailInformation(dessertName: "Blackberry Fool", instructions: "Make the drink.", imageURL: URL(string: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg"), ingredients: [Ingredient(name: "Hazlenuts", measurement: "50g"), Ingredient(name: "Hotdog", measurement: "3")])
        let viewModel = DessertDetailViewModel(dessertProvider: MockDessertProvider())
        let task = await viewModel.getDessertDetails(id: "1234")
        
        await task.value
        
        XCTAssertEqual(mockDessertDetailInfo, viewModel.detailInfo)
        XCTAssert(viewModel.errorMessage.isEmpty)
        XCTAssertFalse(viewModel.errorOccured)
    }
    
    func testDessertDetailInvalidURL() async {
        let viewModel = DessertDetailViewModel(dessertProvider: MockDessertProviderInvalidURL())
        let task = await viewModel.getDessertDetails(id: "1234")
        
        await task.value
        
        XCTAssertEqual(DessertErrors.invalidURL.localizedDescription, viewModel.errorMessage)
        XCTAssertNil(viewModel.detailInfo)
    }
    
    func testDessertMealsNetworkError() async {
        let viewModel = DessertDetailViewModel(dessertProvider: MockDessertProviderNetworkError())
        let task = await viewModel.getDessertDetails(id: "1234")
        
        await task.value
        
        XCTAssertEqual(DessertErrors.networkError.localizedDescription, viewModel.errorMessage)
        XCTAssertNil(viewModel.detailInfo)
    }
    
    func testDessertMealsDecodingError() async {
        let viewModel = DessertDetailViewModel(dessertProvider: MockDessertProviderDecodingError())
        let task = await viewModel.getDessertDetails(id: "1234")
        
        await task.value
        
        XCTAssertEqual(DessertErrors.decodingError.localizedDescription, viewModel.errorMessage)
        XCTAssertNil(viewModel.detailInfo)
    }
}
