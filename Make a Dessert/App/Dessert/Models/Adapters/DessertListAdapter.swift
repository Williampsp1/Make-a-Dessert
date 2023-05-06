//
//  DessertListAdapter.swift
//  Make a Dessert
//
//  Created by William on 5/4/23.
//

import Foundation

enum DessertListAdapter {
    static func desserts(meals: [DessertListMealInfo]) -> [DessertListMealInfo] {
        return meals.sorted { $0.strMeal < $1.strMeal}
    }
}
