//
//  GroceryViewControllerTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler

class GroceryViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
//    func getGroceryList(data: GroceryList) {
//        self.groceryList = data
//        self.tableView.reloadData()
//    }
    func testGetGroceryList(){
        let gl = GroceryViewController()
        let ingredientOne = Ingredient(id:1, name:"Broccoli", notes: nil, ingredientDetails: 5.0, ingredientUnits: "Ounces")
        let ingredientTwo = Ingredient(id:2, name:"Potatoes", notes: nil, ingredientDetails: 1.0, ingredientUnits: "Slices")
        let ingredientThree = Ingredient(id:3, name:"Meat", notes: nil, ingredientDetails: 4.0, ingredientUnits: "Ounces")
        let ingredientArray = [ingredientOne, ingredientTwo, ingredientThree]
        let groceries = GroceryList(ingredientsOwned: ["Meat", "Potatoes"], recipeIngredients: ingredientArray)
        gl.getGroceryList(data: groceries)
        XCTAssertEqual(gl.groceryList!.ingredientsOwned, groceries.ingredientsOwned)
        XCTAssertEqual(gl.groceryList!.ingredientsOwned.count, groceries.ingredientsOwned.count)

    }
    
}
