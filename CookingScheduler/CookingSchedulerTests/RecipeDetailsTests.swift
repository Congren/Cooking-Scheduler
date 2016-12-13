//
//  RecipeDetailsTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler

class RecipeDetailsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRecipeDetails() {
        // This is an example of a performance test case.
        let ingredientOne = Ingredient(id:1, name:"Broccoli", notes: nil, ingredientDetails: 5.0, ingredientUnits: "Ounce")
        let ingredientTwo = Ingredient(id:2, name:"Chedder", notes: nil, ingredientDetails: 1.0, ingredientUnits: "Slices")
        let ingredientArray = [ingredientOne, ingredientTwo]
        let cuisineArray : [String] = ["Meat", "Bread"]
        let recipeTest = RecipeDetails(id:1, title:"Cooking", cookTime:15, instructions: "Test", ingredients:ingredientArray, cuisines:cuisineArray, url:"Fake Url")
        XCTAssertEqual(recipeTest.id, 1)
        XCTAssertEqual(recipeTest.title, "Cooking")
        XCTAssertEqual(recipeTest.cookTime, 15)
        XCTAssertEqual(recipeTest.instructions, "Test")
        XCTAssertEqual(recipeTest.cuisines, cuisineArray)
        XCTAssertEqual(recipeTest.url, "Fake Url")
    }
    
}
