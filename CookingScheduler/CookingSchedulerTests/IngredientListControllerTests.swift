//
//  IngredientListControllerTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//
import CoreData
import XCTest
@testable import CookingScheduler

class IngredientListControllerTests: XCTestCase {
    
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
        let entity = NSEntityDescription.insertNewObject(forEntityName: "GroceryListIngredients", into: managedObjectContext)
        var ingredients = ""
        var recipes: [GroceryListIngredients] = []
        
        entity.setValue("Sugar", forKey:"title")
        entity.setValue("This is a note", forKey:"notes")
        entity.setValue(3.0, forKey:"details")
        entity.setValue("units", forKey:"units")
        do{
            try managedObjectContext.save()
            print("SAVED")
        }
        catch{
            print("Error")
            
        }
        
        do{
            recipes = try managedObjectContext.fetch(GroceryListIngredients.fetchRequest())
            let ivc = IngredientListController()
            ivc.recipes = recipes
            ivc.ingredients = ingredients
            ivc.errorMess = ErrorMessage()
            ivc.generateString()
            XCTAssertEqual(ivc.ingredients, "- Sugar --- 3.0 units \("\n") \("\t")This is a note \("\n")")
        }
        catch{
            print("error")
        }
        
    }
    
    
}
