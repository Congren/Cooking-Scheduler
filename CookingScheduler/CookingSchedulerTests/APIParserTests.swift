//
//  APIParserTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler

class APIParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateRecipe() {
        let API = RecipeParser()
        let dict = ["id" : 5, "title" : "Cooking", "likes" : 1234, "missingIngredientCount" : 5, "image" : "Image"] as [String : Any]
        let newRecipe = API.createRecipe(info: dict)
        XCTAssertEqual(newRecipe?.id, 5)
        XCTAssertEqual(newRecipe?.title, "Cooking")
        XCTAssertEqual(newRecipe?.likes, 1234)
        XCTAssertEqual(newRecipe?.missedIngredients, 5)
        XCTAssertEqual(newRecipe?.imageUrl, "Image")

        

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
