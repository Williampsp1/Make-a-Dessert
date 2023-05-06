//
//  MockDessertProvider.swift
//  Make a Dessert
//
//  Created by William on 5/2/23.
//

import Foundation

struct MockDessertProvider: DessertProviding {
    func getDesserts() async throws -> [DessertListMealInfo] {
        return [DessertListMealInfo(strMeal: "Apple Frangipan Tart", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52768"), DessertListMealInfo(strMeal: "Blackberry Fool", strMealThumb: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", id: "52891")]
    }
    
    func getDessertDetail(id: String) async throws -> DessertDetailInformation {
        return DessertDetailInformation(dessertName: "Blackberry Fool", instructions: "Make the drink.", imageURL: URL(string: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg"), ingredients: [Ingredient(name: "Hazlenuts", measurement: "50g"), Ingredient(name: "Hotdog", measurement: "3")])
    }
}

struct MockDessertProviderInvalidURL: DessertProviding {
    func getDesserts() async throws -> [DessertListMealInfo] {
        throw DessertErrors.invalidURL
    }
    
    func getDessertDetail(id: String) async throws -> DessertDetailInformation {
        throw DessertErrors.invalidURL
    }
}

struct MockDessertProviderNetworkError: DessertProviding {
    func getDesserts() async throws -> [DessertListMealInfo] {
        throw DessertErrors.networkError
    }
    
    func getDessertDetail(id: String) async throws -> DessertDetailInformation {
        throw DessertErrors.networkError
    }
}

struct MockDessertProviderDecodingError: DessertProviding {
    func getDesserts() async throws -> [DessertListMealInfo] {
        throw DessertErrors.decodingError
    }
    
    func getDessertDetail(id: String) async throws -> DessertDetailInformation {
        throw DessertErrors.decodingError
    }
}
