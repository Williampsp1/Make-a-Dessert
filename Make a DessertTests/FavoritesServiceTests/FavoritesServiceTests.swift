//
//  FavoritesServiceTests.swift
//  Make a DessertTests
//
//  Created by William on 7/4/23.
//

import XCTest

final class FavoritesServiceTests: XCTestCase {
    private let mockMeal = DessertListMealInfo(strMeal: "Apple Frangipan Tart", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52768")
    private let mockMeal2 = DessertListMealInfo(strMeal: "Blackberry Fool", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52891")

    func testAddFavoriteId() async {
        let service = FavoritesService(dessertProvider: MockDessertProvider())
        service.favoriteIds = []
        XCTAssertEqual(service.loadingState, .loading)
        
        let task = await service.fetchFavorites()
        await task.value
        
        XCTAssertEqual(service.loadingState, .noFavorites)
        XCTAssertEqual(service.favoriteIds, [])
        XCTAssertEqual(service.favoriteMeals, [])
        
        service.addOrRemove(mockMeal.id)
        XCTAssertEqual(service.favoriteIds[0], mockMeal.id)
        XCTAssertEqual(service.favoriteMeals[0], mockMeal)
        service.addOrRemove(mockMeal2.id)
        XCTAssertEqual(service.favoriteIds[1], mockMeal2.id)
        XCTAssertEqual(service.favoriteMeals[1], mockMeal2)
        
        let task2 = await service.fetchFavorites()
        await task2.value
        
        XCTAssertEqual(service.loadingState, .loaded)
    }
    
    func testLoadFavoriteIDs() async {
        let service = FavoritesService(dessertProvider: MockDessertProvider())
        service.favoriteIds = []
        XCTAssertEqual(service.loadingState, .loading)
        
        service.addOrRemove(mockMeal.id) // Adds it to user defaults
        
        let service2 = FavoritesService(dessertProvider: MockDessertProvider())
        XCTAssertEqual(service2.favoriteIds[0], mockMeal.id)
        XCTAssertEqual(service.loadingState, .loading)
        
        let task = await service.fetchFavorites()
        await task.value
        
        XCTAssertEqual(service.loadingState, .loaded)
    }
    
    func testRemoveFavoriteID() async {
        let service = FavoritesService(dessertProvider: MockDessertProvider())
        service.favoriteIds = []
        XCTAssertEqual(service.loadingState, .loading)
        
        service.addOrRemove(mockMeal.id)
        XCTAssertEqual(service.favoriteIds[0], mockMeal.id)
        
        let task = await service.fetchFavorites()
        await task.value
        
        XCTAssertEqual(service.loadingState, .loaded)
        
        service.addOrRemove(mockMeal.id)
        XCTAssertEqual(service.favoriteIds.count, 0)
        
        let task2 = await service.fetchFavorites()
        await task2.value
        
        XCTAssertEqual(service.loadingState, .noFavorites)
    }
    
    func testFetchFavoritesInvalidURL() async {
        let service = FavoritesService(dessertProvider: MockDessertProviderInvalidURL())
        service.favoriteIds = [mockMeal.id]
        XCTAssertEqual(service.loadingState, .loading)
        
        let task = await service.fetchFavorites()
        await task.value
        
        XCTAssertEqual(service.loadingState, .error)
        XCTAssert(service.favoriteMeals.isEmpty)
        XCTAssertEqual(service.errorMessage, DessertErrors.invalidURL.localizedDescription)
    }
    
    func testFetchFavoritesNetworkError() async {
        let service = FavoritesService(dessertProvider: MockDessertProviderNetworkError())
        service.favoriteIds = [mockMeal.id]
        XCTAssertEqual(service.loadingState, .loading)
        
        let task = await service.fetchFavorites()
        await task.value
        
        XCTAssertEqual(service.loadingState, .error)
        XCTAssert(service.favoriteMeals.isEmpty)
        XCTAssertEqual(service.errorMessage, DessertErrors.networkError.localizedDescription)
    }
    
    func testFetchFavoritesDecodingError() async {
        let service = FavoritesService(dessertProvider: MockDessertProviderDecodingError())
        service.favoriteIds = [mockMeal.id]
        XCTAssertEqual(service.loadingState, .loading)
        
        let task = await service.fetchFavorites()
        await task.value
        
        XCTAssertEqual(service.loadingState, .error)
        XCTAssert(service.favoriteMeals.isEmpty)
        XCTAssertEqual(service.errorMessage, DessertErrors.decodingError.localizedDescription)
    }
}
