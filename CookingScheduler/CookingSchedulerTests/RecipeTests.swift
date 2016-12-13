//
//  RecipeTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler

class RecipeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRecipe(){
        let recipe = Recipe(id:1, title:"Meat and Potatoes", missedIngredients: 5 , likes:1000, imageUrl:"test image")
        XCTAssertEqual(recipe.id, 1)
        XCTAssertEqual(recipe.title, "Meat and Potatoes")
        XCTAssertEqual(recipe.missedIngredients, 5)
        XCTAssertEqual(recipe.likes, 1000)
        XCTAssertEqual(recipe.imageUrl, "test image")
    }
    
}
