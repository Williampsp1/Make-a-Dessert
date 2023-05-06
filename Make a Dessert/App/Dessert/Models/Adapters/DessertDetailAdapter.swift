//
//  DessertDetailAdapter.swift
//  Make a Dessert
//
//  Created by William on 5/3/23.
//

import Foundation

enum DessertDetailAdapter {
    static func dessert(details: DessertDetails) -> DessertDetailInformation {
        var ingredients: [Ingredient] {
            var ingredients: [Ingredient] = []
            let mirror = Mirror(reflecting: details)
            for child in mirror.children {
                if let label = child.label, label.hasPrefix("strIngredient"),
                   let ingredientName = child.value as? String,
                   !ingredientName.isEmpty {
                    let measureLabel = label.replacingOccurrences(of: "strIngredient", with: "strMeasure")
                    if let measureValue = mirror.children.first(where: { $0.label == measureLabel })?.value as? String,
                       !measureValue.isEmpty {
                        let ingredient = Ingredient(name: ingredientName, measurement: measureValue)
                        ingredients.append(ingredient)
                    }
                }
            }
            return ingredients.uniqued()
        }
        
        return DessertDetailInformation(dessertName: details.strMeal, instructions: details.strInstructions, imageURL: URL(string: details.strMealThumb), ingredients: ingredients)
    }
}
