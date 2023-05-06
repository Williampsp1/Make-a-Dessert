//
//  IngredientsView.swift
//  Make a Dessert
//
//  Created by William on 5/2/23.
//

import SwiftUI

struct IngredientsView: View {
    let ingredients: [Ingredient]
    
    var body: some View {
        VStack {
            Text("Ingredients:")
                .modifier(TextModifier())
            
            VStack(spacing: 3) {
                ForEach(ingredients, id: \.self) { ingredient in
                    HStack {
                        if ingredient.measurement.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil || ingredient.measurement.unicodeScalars.contains(where: {
                            UnicodeScalar("\u{00BC}")..."\u{00BE}" ~= $0
                        }) {
                            Text("\(ingredient.name.capitalized):")
                            Text(ingredient.measurement)
                        } else {
                            Text("\(ingredient.measurement.capitalized):")
                            Text(ingredient.name.capitalized)
                        }
                    }
                    .font(.system(.subheadline, design: .serif, weight: .medium))
                }
            }
            .modifier(TextBackgroundModifier())
        }
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView(ingredients: [Ingredient(name: "Hotdog", measurement: "3"), Ingredient(name: "sugar", measurement: "Garnish with")])
    }
}
