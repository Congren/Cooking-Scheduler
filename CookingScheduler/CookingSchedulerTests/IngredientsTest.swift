//
//  IngredientsTest.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler

class IngredientsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIngredient() {
        // This is an example of a performance test case.
        let ingredient = Ingredient(id:1, name:"Broccoli", notes: nil, ingredientDetails: 5.0, ingredientUnits: "Ounce")
        XCTAssertEqual(ingredient.id, 1)
        XCTAssertEqual(ingredient.name, "Broccoli")
        XCTAssertNil(ingredient.notes)
        XCTAssertEqual(ingredient.ingredientDetails, 5.0)
        XCTAssertEqual(ingredient.ingredientUnits, "Ounce")
    }
    
}
