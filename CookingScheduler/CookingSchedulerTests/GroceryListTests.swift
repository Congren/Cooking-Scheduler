//
//  GroceryListTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler

class GroceryListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCompareIngredients(){
        let ingredientOne = Ingredient(id:1, name:"Broccoli", notes: nil, ingredientDetails: 5.0, ingredientUnits: "Ounces")
        let ingredientTwo = Ingredient(id:2, name:"Potatoes", notes: nil, ingredientDetails: 1.0, ingredientUnits: "Slices")
        let ingredientThree = Ingredient(id:3, name:"Meat", notes: nil, ingredientDetails: 4.0, ingredientUnits: "Ounces")
        let ingredientArray = [ingredientOne, ingredientTwo, ingredientThree]
        let groceries = GroceryList(ingredientsOwned: ["Meat", "Potatoes"], recipeIngredients: ingredientArray)
        let neededIngredients = groceries.compareIngredients()
        let testNeeded = ingredientOne.name
        let neededName = neededIngredients[0].name
        XCTAssertTrue(neededName == testNeeded)
    }
    
}
