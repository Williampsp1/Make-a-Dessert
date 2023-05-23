//
//  FavoritesListView.swift
//  Make a Dessert
//
//  Created by William on 5/12/23.
//

import SwiftUI

struct DessertFavoritesListView: View {
    @EnvironmentObject private var viewModel: DessertListViewModel
    
    var body: some View {
        Group {
            if !viewModel.favoriteMeals.isEmpty {
                DessertListingView(meals: viewModel.favoriteMeals)
                
            } else {
                Text("No favorites added yet.")
                    .font(.system(size: 20, weight: .medium))
            }
        }
        .onAppear {
            viewModel.fetchFavorites()
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertFavoritesListView()
            .environmentObject(DessertListViewModel(dessertProvider: DessertProvider()))
    }
}
