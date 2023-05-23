//
//  CacheImageTests.swift
//  Make a DessertTests
//
//  Created by Rafaela on 5/13/23.
//

import XCTest
import SwiftUI

final class CacheImageTests: XCTestCase {
    private var image = Image(systemName: "star")
    private let url = URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!
    
    override func tearDown() {
        MockImageCache[url] = nil
    }

    func testImageCache() {
        MockImageCache[url] = image
        
        XCTAssertEqual(MockImageCache[url], image)
    }
    
    func testImageCacheNil() {
        XCTAssertEqual(MockImageCache[url], nil)
    }
}
