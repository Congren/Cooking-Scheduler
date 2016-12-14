//
//  RecipeTableViewControllerTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler

@available(iOS 10.0, *)
class RecipeTableViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetIngredient() {
        let API = RecipesTableViewController()
        let recipe = [Recipe(id:1, title:"Meat and Potatoes", missedIngredients: 5 , likes:1000, imageUrl:"test image")]
        API.dataReceived(data: recipe as NSArray)
        let data = API.recipes
        XCTAssertEqual(data[0].title, recipe[0].title)
        XCTAssertEqual(data.count, recipe.count)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
