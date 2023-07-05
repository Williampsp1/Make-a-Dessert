//
//  DessertDetailView.swift
//  Make a Dessert
//
//  Created by William on 5/1/23.
//

import SwiftUI

struct DessertDetailView: View {
    @StateObject private var viewModel = DessertDetailViewModel()
    @EnvironmentObject private var favoriteService: FavoritesService
    
    let meal: DessertListMealInfo
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                switch viewModel.loadingState {
                case .error: errorButton
                case .loaded: detailInfo
                case .loading: ProgressView()
                }
            }
        }
        .padding(10)
        .navigationTitle("Dessert Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getDessertDetails(id: meal.id)
        }
    }
    
    @ViewBuilder
    private var detailInfo: some View {
        if let detailInfo = viewModel.detailInfo {
            favoriteButton
            
            if let url = detailInfo.imageURL {
                DessertImageView(image: url)
            } else {
                Image(systemName: "questionmark.diamond")
            }
            
            Text(detailInfo.dessertName)
                .multilineTextAlignment(.center)
                .font(.system(size: 42, weight: .bold, design: .serif))
                .modifier(ShadowModifier())
            
            DessertIngredientsView(ingredients: detailInfo.ingredients)
            
            Text("Instructions:")
                .modifier(TextModifier())
            
            Text(detailInfo.instructions)
                .font(.subheadline)
                .modifier(TextBackgroundModifier())
        }
    }
    
    private var favoriteButton: some View {
        Button(action: {
            favoriteService.addOrRemove(meal.id)
        }) {
            HStack {
                Spacer()
                Text(favoriteService.favoriteIds.contains(meal.id) ? "Unfavorite" : "Favorite")
                    .foregroundColor(.primary)
                Image(systemName: favoriteService.favoriteIds.contains(meal.id) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            .font(.headline)
        }
    }
    
    private var errorButton: some View {
        VStack {
            Text("Error fetching dessert details. Please try again.")
            Button(action: {
                viewModel.getDessertDetails(id: meal.id)
            }) {
                Text("Fetch Dessert Details")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static let previewArray = [DessertListMealInfo(strMeal: "", strMealThumb: "", id: "52891")]
    static let previewMeal = DessertListMealInfo(strMeal: "", strMealThumb: "", id: "52891")
    
    static var previews: some View {
        NavigationView {
            DessertDetailView(meal: previewMeal)
                .environmentObject(FavoritesService())
        }
    }
}
