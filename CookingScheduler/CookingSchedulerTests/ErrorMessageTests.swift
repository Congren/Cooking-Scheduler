//
//  ErrorMessageTests.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/13/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import XCTest
@testable import CookingScheduler

class ErrorMessageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testErrorMessage() {
        let error = ErrorMessage()
        let errorTest = error.createErrorMessage(title: "test", message: "test message")
        XCTAssertEqual(errorTest.title, "test")
        XCTAssertEqual(errorTest.message, "test message")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
