//
//  DessertHomeView.swift
//  Make a Dessert
//
//  Created by William on 5/12/23.
//

import SwiftUI

struct DessertHomeView: View {
    @StateObject private var dessertHomeViewModel = DessertHomeViewModel()
    @StateObject private var viewModel = DessertListViewModel(dessertProvider: DessertProvider())
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Dessert View", selection: $dessertHomeViewModel.selectedView) {
                    Text("All Desserts").tag(DessertHomeViewModel.DessertViews.allDesserts)
                    Text("Favorites").tag(DessertHomeViewModel.DessertViews.favorites)
                }
                .padding(.top, 10.0)
                .padding(.horizontal, 40)
                .pickerStyle(.segmented)
                
                if dessertHomeViewModel.selectedView == .allDesserts {
                    DessertListView()
                } else {
                    Spacer()
                    DessertFavoritesListView()
                }
                Spacer()
            }
            .navigationTitle("Make a Dessert!")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .scrollContentBackground(.hidden)
        .environmentObject(viewModel)
    }
}

struct DessertHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DessertHomeView()
    }
}
