//
//  FavoritesListView.swift
//  Make a Dessert
//
//  Created by William on 5/12/23.
//

import SwiftUI

struct DessertFavoritesListView: View {
    @EnvironmentObject private var favoriteService: FavoritesService
    
    var body: some View {
        Group {
            switch favoriteService.loadingState {
            case .error: Text("Error fetching favorites. Please try again.")
            case .loaded: DessertListingView(meals: favoriteService.favoriteMeals)
            case .noFavorites: Text("No favorites added yet.")
                    .font(.system(size: 20, weight: .medium))
            case .loading: ProgressView()
            }
        }
        .onAppear {
            favoriteService.fetchFavorites()
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DessertFavoritesListView()
                .environmentObject(FavoritesService())
        }
    }
}
