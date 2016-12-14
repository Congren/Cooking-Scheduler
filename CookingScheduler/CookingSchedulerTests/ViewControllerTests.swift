//
//  ViewControllerTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//
import CoreData
import XCTest
@testable import CookingScheduler

@available(iOS 10.0, *)
class ViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetData(){
        let managedObjectContext = setUpInMemoryManagedObjectContext()
        let entity = NSEntityDescription.insertNewObject(forEntityName: "SavedRecipes", into: managedObjectContext)
        entity.setValue("ingredients", forKey:"ingredients")
        entity.setValue("instructions", forKey:"recipe")
        entity.setValue("ingredient details", forKey:"ingredientDetail")
        entity.setValue("ingredient units", forKey:"ingredientUnit")
        do{
            try managedObjectContext.save()
            print("SAVED")
        }
        catch{
            print("Error")

        }
        var recipes: [SavedRecipes] = []
        
        do{
            recipes = try managedObjectContext.fetch(SavedRecipes.fetchRequest())
        }catch{
            print("oh no")
        }
        XCTAssertEqual(recipes[0].id, 0)
        XCTAssertEqual(recipes[0].ingredients, "ingredients")
        XCTAssertEqual(recipes[0].recipe, "instructions")
        XCTAssertEqual(recipes[0].ingredientDetail, "ingredient details")
        XCTAssertEqual(recipes[0].ingredientUnit, "ingredient units")
    }
    
}
