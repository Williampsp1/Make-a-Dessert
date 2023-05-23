//
//  DessertHomeViewModel.swift
//  Make a Dessert
//
//  Created by William on 5/12/23.
//

import Foundation

class DessertHomeViewModel: ObservableObject {
    @Published var selectedView: DessertViews = .allDesserts
    
    enum DessertViews {
        case allDesserts
        case favorites
    }
}
