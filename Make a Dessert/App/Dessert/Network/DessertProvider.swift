//
//  NetworkService.swift
//  Make a Dessert
//
//  Created by William on 5/1/23.
//

import Foundation

protocol DessertProviding {
    func getDesserts() async throws -> [DessertListMealInfo]
    func getDessertDetail(id: String) async throws -> DessertDetailInformation
}

enum DessertErrors: Error, LocalizedError {
    case invalidURL
    case networkError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network error occurred"
        case .decodingError:
            return "Decoding error occurred"
        case .invalidURL:
            return "Invalid URL provided"
        }
    }
}

struct DessertProvider: DessertProviding {
    private let dessertMealsURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
    private let dessertUrl = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php")
    
    func getDesserts() async throws -> [DessertListMealInfo] {
        guard let mealsURL = dessertMealsURL else {
            throw DessertErrors.invalidURL
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: mealsURL) else {
            throw DessertErrors.networkError
        }
        
        guard let dessertsMeals = try? JSONDecoder().decode(DessertMeals.self, from: data) else {
            throw DessertErrors.decodingError
        }
        
        return DessertListAdapter.desserts(meals: dessertsMeals.meals)
    }
    
    func getDessertDetail(id: String) async throws -> DessertDetailInformation {
        guard let detailURL = dessertUrl?.appending(queryItems: [URLQueryItem(name: "i", value: id)]) else {
            throw DessertErrors.invalidURL
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: detailURL) else {
            throw DessertErrors.networkError
        }
        
        guard let dessert = try? JSONDecoder().decode(Dessert.self, from: data).meals.first else {
            throw DessertErrors.decodingError
        }
        
        return DessertDetailAdapter.dessert(details: dessert)
    }
}

