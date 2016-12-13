//
//  FavoriteTableViewControllerTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler

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
        let ftv = FavoritedTableViewController()
        ftv.getData()
        print(ftv.recipes)
        //XCTAssertEqual()
    }
    
}
