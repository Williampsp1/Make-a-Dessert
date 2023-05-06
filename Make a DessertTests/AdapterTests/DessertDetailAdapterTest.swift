//
//  DessertDetailAdapterTest.swift
//  Make a DessertTests
//
//  Created by William on 5/3/23.
//

import XCTest

final class DessertDetailAdapterTest: XCTestCase {
    
    func testDessertDetailAdapter() throws {
        let mockDessertDetailInfo = DessertDetailInformation(dessertName: "Bread and Butter Pudding", instructions: "Grease a 1 litre pint pie dish with butter.", imageURL: URL(string: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg"), ingredients: [Ingredient(name: "butter", measurement: "1oz")])
        guard let file = Bundle.main.url(forResource: "MockDessertDetail", withExtension: "json") else {
            return XCTFail()
        }
        
        let dessertDetails = try JSONDecoder().decode(DessertDetails.self, from: Data(contentsOf: file))
        
        let dessertDetailInfo = DessertDetailAdapter.dessert(details: dessertDetails)
        XCTAssertEqual(mockDessertDetailInfo, dessertDetailInfo)
    }
}
