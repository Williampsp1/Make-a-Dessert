//
//  DessertListAdapterTest.swift
//  Make a DessertTests
//
//  Created by William on 5/4/23.
//

import XCTest

final class DessertListAdapterTest: XCTestCase {
    
    func testDessertListAdapter() {
        let mockDessertMeals = [DessertListMealInfo(strMeal: "Blackberry Fool", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52891"), DessertListMealInfo(strMeal: "Apple Frangipan Tart", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52768")]
        let mockSortedDessertMeals = [DessertListMealInfo(strMeal: "Apple Frangipan Tart", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52768"), DessertListMealInfo(strMeal: "Blackberry Fool", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52891")]
        
        let sortedMeals = DessertListAdapter.desserts(meals: mockDessertMeals)
        
        XCTAssertEqual(mockSortedDessertMeals, sortedMeals)
    }
    
}
