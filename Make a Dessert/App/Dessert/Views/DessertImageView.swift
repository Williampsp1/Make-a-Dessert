//
//  CachedImageView.swift
//  Make a Dessert
//
//  Created by William on 5/2/23.
//

import SwiftUI

struct DessertImageView: View {
    let image: URL
    var body: some View {
        CacheAsyncImage(
            url: image
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                    .modifier(ShadowModifier())
            case .failure(let error):
                Image(systemName: "questionmark.diamond")
                let _ = print(error.localizedDescription)
            @unknown default:
                let _ = print("Error")
                Image(systemName: "questionmark")
            }
        }
    }
}
