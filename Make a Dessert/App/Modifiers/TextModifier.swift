//
//  TextModifier.swift
//  Make a Dessert
//
//  Created by William on 5/4/23.
//

import SwiftUI

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .serif, weight: .semibold))
    }
}
