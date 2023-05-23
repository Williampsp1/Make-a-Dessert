//
//  DessertDetailView.swift
//  Make a Dessert
//
//  Created by William on 5/1/23.
//

import SwiftUI

struct DessertDetailView: View {
    @StateObject private var viewModel = DessertDetailViewModel(dessertProvider: DessertProvider())
    @EnvironmentObject private var listViewModel: DessertListViewModel
    
    let meal: DessertListMealInfo
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                if viewModel.errorOccured {
                    errorButton
                } else if let detailInfo = viewModel.detailInfo {
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
                    
                    VStack {
                        Text(detailInfo.instructions)
                            .font(.subheadline)
                    }
                    .modifier(TextBackgroundModifier())
                } else {
                    ProgressView()
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
    
    var favoriteButton: some View {
        Button(action: {
            listViewModel.addOrRemove(meal.id)
        }) {
            HStack {
                Spacer()
                if listViewModel.favoriteIds.contains(meal.id) {
                    Text("Unfavorite")
                        .foregroundColor(.primary)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                } else {
                    Text("Favorite")
                        .foregroundColor(.primary)
                    Image(systemName: "star")
                        .foregroundColor(Color.yellow)
                    
                }
            }
            .font(.headline)
        }
    }
    
    var errorButton: some View {
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
        DessertDetailView(meal: previewMeal)
            .environmentObject(DessertListViewModel(dessertProvider: DessertProvider()))
    }
}
