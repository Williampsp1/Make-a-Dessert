//
//  Desserts.swift
//  Make a Dessert
//
//  Created by William on 5/1/23.
//

import Foundation

struct DessertMeals: Codable {
    let meals: [DessertListMealInfo]
}

struct DessertListMealInfo: Codable, Identifiable, Equatable {
    let strMeal: String
    let strMealThumb: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strMealThumb
    }
}

extension DessertListMealInfo {
    var mealURL: URL? {
        return URL(string: strMealThumb)
    }
}
