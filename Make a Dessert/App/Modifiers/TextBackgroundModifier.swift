//
//  TextBackgroundModifier.swift
//  Make a Dessert
//
//  Created by William on 5/5/23.
//

import SwiftUI

struct TextBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(.gray.opacity(0.2))
            .cornerRadius(12)
    }
}
