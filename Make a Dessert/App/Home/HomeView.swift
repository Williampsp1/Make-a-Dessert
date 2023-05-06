//
//  HomeView.swift
//  Make a Dessert
//
//  Created by William on 5/1/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            DessertListView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
