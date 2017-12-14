//
//  DefaultsBugUITests.swift
//  DefaultsBugUITests
//
//  Created by Omada Developer on 12/14/17.
//  Copyright © 2017 Omada Developer. All rights reserved.
//

import XCTest

class DefaultsBugUITests: XCTestCase {

    var app: XCUIApplication!


    override func setUp() {
        super.setUp()

        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    func test1ReadDefaults() {
        app.buttons["not seen"].tap()
        XCTAssert(app.buttons["seen"].exists)
    }

    func test2ReadDefaults() {
        app.buttons["seen"].tap()
        XCTAssert(app.buttons["not seen"].exists)
    }

}
