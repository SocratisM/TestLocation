//
//  TestLocationUITests.swift
//  TestLocationUITests
//
//  Created by Socratis Michaelides on 12/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import XCTest

class TestLocationUITests: XCTestCase {
  
  var topLevelApp: XCUIApplication? = nil

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        topLevelApp = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        topLevelApp = nil

    }
  
    func testAddLocationInteraction() {
       testIntroInteraction()
       topLevelApp?.navigationBars["Select location"].buttons["Add"].tap()
       let placeTextField = topLevelApp?.textFields["Enter place "]
       placeTextField?.tap()
       placeTextField?.typeText("Amsterdam")
      
       let latitudeTextField = topLevelApp?.textFields["Enter Latitude(Optional)"]
       latitudeTextField?.tap()
       latitudeTextField?.typeText("12345")
      
       let longitutdeTextField = topLevelApp?.textFields["Enter Longitude(Optional)"]
       longitutdeTextField?.tap()
       longitutdeTextField?.typeText("-1234.330")
      
       topLevelApp?.buttons["Done"].tap()
        
       // test new cell count
       let table = topLevelApp?.tables
       XCTAssertEqual(table?.cells.count, 11)
    }
    
    func testIntroInteraction() {
       topLevelApp?.otherElements.containing(.navigationBar, identifier:"Intro").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
       topLevelApp?.buttons["Got it!"].tap()
        
       // test initial cell count
       let table = topLevelApp?.tables
       XCTAssertEqual(table?.cells.count, 10)
    }
}
