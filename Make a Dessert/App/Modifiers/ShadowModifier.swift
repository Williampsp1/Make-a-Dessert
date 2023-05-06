//
//  ShadowModifier.swift
//  Make a Dessert
//
//  Created by William on 5/4/23.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}
