//
//  FavoriteTableViewControllerTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler
import CoreData

@available(iOS 10.0, *)
class FavoritedTableViewControllerTests: XCTestCase {
    
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
        let entity = NSEntityDescription.insertNewObject(forEntityName: "FavoritedRecipes", into: managedObjectContext)
        entity.setValue("image", forKey:"imageUrl")
        entity.setValue("ingredient details", forKey:"ingredients")
        entity.setValue("ingredient name", forKey:"name")
        do{
            try managedObjectContext.save()
            print("SAVED")
        }
        catch{
            print("Error")
            
        }
        var recipes = [FavoritedRecipes]()
        
        do{
            recipes = try managedObjectContext.fetch(FavoritedRecipes.fetchRequest())
        }catch{
            print("oh no")
        }
        XCTAssertEqual(recipes[0].id, 0)
        XCTAssertEqual(recipes[0].ingredients, "ingredient details")
        XCTAssertEqual(recipes[0].imageUrl, "image")
        XCTAssertEqual(recipes[0].name, "ingredient name")
    }

    
}
