//
//  DessertDetailView.swift
//  Make a Dessert
//
//  Created by William on 5/1/23.
//

import SwiftUI

struct DessertDetailView: View {
    @StateObject private var viewModel = DessertDetailViewModel(dessertProvider: DessertProvider())
    let id: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                if viewModel.errorOccured {
                    VStack {
                        Text("Error fetching dessert details. Please try again.")
                        Button(action: {
                            viewModel.getDessertDetails(id: id)
                        }) {
                            Text("Fetch Dessert Details")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else if let detailInfo = viewModel.detailInfo {
                    if let url = detailInfo.imageURL {
                        DessertImageView(image: url)
                    } else {
                        Image(systemName: "questionmark.diamond")
                    }
                    
                    Text(detailInfo.dessertName)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 42, weight: .bold, design: .serif))
                        .modifier(ShadowModifier())
                    
                    IngredientsView(ingredients: detailInfo.ingredients)
                    
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
            viewModel.getDessertDetails(id: id)
        }
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView(id: "52891")
    }
}
