//
//  DessertListView.swift
//  Make a Dessert
//
//  Created by William on 5/2/23.
//

import SwiftUI

struct DessertListView: View {
    @EnvironmentObject private var viewModel: DessertListViewModel
    
    var body: some View {
        Group {
            if viewModel.errorOccured {
                VStack {
                    Text("Error fetching desserts. Please try again.")
                    Button(action: {
                        viewModel.getDessertMeals()
                    }) {
                        Text("Fetch Desserts")
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else if !viewModel.dessertListMeals.isEmpty {
                DessertListingView(meals: viewModel.dessertListMeals)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.getDessertMeals()
        }
    }
}

struct DessertListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DessertListView()
        }
        .environmentObject(DessertListViewModel(dessertProvider: DessertProvider()))
    }
}
