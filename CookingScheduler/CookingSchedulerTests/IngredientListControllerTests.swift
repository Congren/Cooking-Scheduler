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
        let entity = NSEntityDescription.insertNewObject(forEntityName: "SavedRecipes", into: managedObjectContext)
        var ingredients = ""
        var recipes: [SavedRecipes] = []
        var ingredientList: [String: [String]] = [:]
        
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
        
        do{
            recipes = try managedObjectContext.fetch(SavedRecipes.fetchRequest())
        }
        catch{
            print("error")
        }
        
        for i in recipes{
            if let itemList = i.ingredients{
                if let itemDetails = i.ingredientDetail{
                    if let itemUnits = i.ingredientUnit {
                        let itemArray = itemList.components(separatedBy: ",")
                        let detailArray = itemDetails.components(separatedBy: ",")
                        let unitArray = itemUnits.components(separatedBy: ",")
                        for n in 0..<itemArray.count{
                            if !Array(ingredientList.keys).contains(itemArray[n]){
                                ingredientList[itemArray[n]] = []
                                ingredientList[itemArray[n]] = [detailArray[n], unitArray[n]]
                            }else{
                                if let extra = Double(detailArray[n]) {
                                    let value = Double((ingredientList[itemArray[n]]?[0])!)! + extra
                                    ingredientList[itemArray[n]]![0] = String(value)
                                }
                            }
                        }
                    }
                    //print(ingredientList)
                }
            }
        }
        for pair in ingredientList{
            ingredients += pair.0 + " " + String(pair.1[0]) + " " + String(pair.1[1])
        }
        XCTAssertEqual(ingredients, "ingredients ingredient details ingredient units")
    }
    
    
}
