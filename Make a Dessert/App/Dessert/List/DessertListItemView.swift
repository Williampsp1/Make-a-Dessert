//
//  DessertListItemView.swift
//  Make a Dessert
//
//  Created by William on 5/1/23.
//

import SwiftUI

struct DessertListItemView: View {
    let dessert: DessertListMealInfo
    
    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            if let url = dessert.mealURL {
                DessertImageView(image: url)
            } else {
                Image(systemName: "questionmark.diamond")
            }
            
            Text(dessert.strMeal)
                .font(.system(size: 20, weight: .medium, design: .serif))
        }
        .frame(height: 80)
    }
}

struct DessertListItemView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListItemView(dessert: DessertListMealInfo(strMeal: "Ice Cream", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", id: "52891"))
            .padding()
    }
}
