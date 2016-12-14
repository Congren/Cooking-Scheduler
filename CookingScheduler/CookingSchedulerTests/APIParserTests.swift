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
        let dict = ["id" : 5, "title" : "Cooking", "likes" : 1234, "missedIngredientCount" : 5, "image" : "Image"] as [String : Any]
        let newRecipe = API.createRecipe(info: dict)
        XCTAssertEqual(newRecipe?.id, 5)
        XCTAssertEqual(newRecipe?.title, "Cooking")
        XCTAssertEqual(newRecipe?.likes, 1234)
        XCTAssertEqual(newRecipe?.missedIngredients, 5)
        XCTAssertEqual(newRecipe?.imageUrl, "Image")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testParseDictionary() {
        let data = loadJSONTestData("response_test_data")
        let API = RecipeParser()
        let parsedDetails = API.parseDictionary(data: data as NSData?) as! [Recipe]
        let first = parsedDetails.first
        XCTAssertEqual(first?.title, "Maple-Bacon Kettle Popcorn")
        XCTAssertEqual(first?.id, 507950)
    }
    func testParseDetails() {
        let data = loadJSONTestData("recipe_info_response")
        let API = RecipeParser()
        let parsedDetails = API.parseDetails(data: data as NSData?)
        XCTAssertEqual(parsedDetails?.title, "Maple-Bacon Kettle Popcorn")
        XCTAssertEqual(parsedDetails?.cookTime, 35)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testGetIngredient() {
        let API = RecipeParser()
        let dict = ["id" : 4, "name" : "Broccoli", "amount" : 5, "unit" : "Pieces"] as [String : Any]
        let newRecipe = API.getIngredient(info: dict)
        XCTAssertEqual(newRecipe?.id, 4)
        XCTAssertEqual(newRecipe?.name, "Broccoli")
        XCTAssertEqual(newRecipe?.ingredientDetails, 5)
        XCTAssertEqual(newRecipe?.ingredientUnits, "Pieces")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testCreateRecipeDetails() {
        let API = RecipeParser()
        let cuisineArray : [String] = ["Meat", "Bread"]
        let ingre = [["id" : 4, "name" : "Broccoli", "amount" : 5, "unit" : "Pieces"] as [String : Any]]
        let dict = ["id" : 4, "title" : "Broccoli", "readyInMinutes" : 50, "instructions" : "test", "extendedIngredients" : ingre, "cuisines" : cuisineArray, "spoonacularSourceUrl" : "url"] as [String : Any]
        let newRecipe = API.createRecipeDetails(info: dict)
        XCTAssertEqual(newRecipe?.id, 4)
        XCTAssertEqual(newRecipe?.title, "Broccoli")
        XCTAssertEqual(newRecipe?.cookTime, 50)
        XCTAssertEqual(newRecipe?.instructions, "test")
        XCTAssertTrue(newRecipe?.ingredients.count == 1)
        XCTAssertEqual((newRecipe?.cuisines)!, cuisineArray)
        XCTAssertEqual(newRecipe?.url, "url")

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func loadJSONTestData(_ filename: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}
