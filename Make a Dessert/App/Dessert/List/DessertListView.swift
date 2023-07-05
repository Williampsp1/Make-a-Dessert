//
//  DessertListView.swift
//  Make a Dessert
//
//  Created by William on 5/2/23.
//

import SwiftUI

struct DessertListView: View {
    @ObservedObject var viewModel: DessertListViewModel
    
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .error: errorButton
            case .loaded: DessertListingView(meals: viewModel.dessertListMeals)
            case .loading: ProgressView()
            }
        }
        .onAppear {
            viewModel.getDessertMeals()
        }
    }
    
    private var errorButton: some View {
        VStack {
            Text("Error fetching desserts. Please try again.")
            Button(action: {
                viewModel.getDessertMeals()
            }) {
                Text("Fetch Desserts")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct DessertListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DessertListView(viewModel: DessertListViewModel())
        }
        .environmentObject(FavoritesService())
    }
}
