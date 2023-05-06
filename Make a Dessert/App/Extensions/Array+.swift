//
//  Array+.swift
//  Make a Dessert
//
//  Created by William on 5/3/23.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
