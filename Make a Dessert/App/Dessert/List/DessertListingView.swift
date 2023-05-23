//
//  DessertListingView.swift
//  Make a Dessert
//
//  Created by William on 5/12/23.
//

import SwiftUI

struct DessertListingView: View {
    var meals: [DessertListMealInfo]
    
    var body: some View {
        List {
            ForEach(meals) { meal in
                NavigationLink(destination: DessertDetailView(meal: meal)) {
                    DessertListItemView(dessert: meal)
                }
            }
        }
    }
}

struct DessertListingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DessertListingView(meals: [DessertListMealInfo(strMeal: "Ice Cream", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", id: "52891"), DessertListMealInfo(strMeal: "Ice Cream", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", id: "52891")])
        }
        .environmentObject(DessertListViewModel(dessertProvider: DessertProvider()))
    }
}
