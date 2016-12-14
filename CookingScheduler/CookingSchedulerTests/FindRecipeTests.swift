//
//  FindRecipeTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler

class FindRecipeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMakeIngredients() {
        let fr = FindRecipe()
        let test = fr.makeString(array: ["Meat", "Potatoes"])
        XCTAssertEqual(test, "Meat%2CPotatoes")
    }
    
    func testGetRecipe(){
        let fr = FindRecipe()
        let ingredients = ["Meat", "Potatoes", "Cheese"]
        let rp = RecipeParser()
        fr.getRecipe(ingredients: ingredients as NSArray){ NSData in
            let json = rp.parseDictionary(data: NSData)
            print ("this is")
            print (json)
            
        }
        //XCTAssertTrue()
        
    }
    
    func testGetRecipeDetails(){
        let fr = FindRecipe()
        let rp = RecipeParser()
        fr.getRecipeDetails(id: 3235){ NSData in
            let json = rp.parseDictionary(data: NSData)
            print (json)
        }
    }
    
}
