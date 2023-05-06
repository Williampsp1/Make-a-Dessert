//
//  DessertListView.swift
//  Make a Dessert
//
//  Created by William on 5/2/23.
//

import SwiftUI

struct DessertListView: View {
    @StateObject private var viewModel = DessertListViewModel(dessertProvider: DessertProvider())
    
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
                List {
                    ForEach(viewModel.dessertListMeals) { meal in
                        NavigationLink(destination: DessertDetailView(id: meal.id)) {
                            DessertListItemView(dessert: meal)
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Make a Dessert!")
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
    }
}
