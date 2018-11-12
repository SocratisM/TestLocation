//
//  TestLocationTests.swift
//  TestLocationTests
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import XCTest
import Core

@testable import TestLocation

class TestLocationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
    func testLocationValidator() {
        let validator = LocationValidatorConcrete()
        let location = Location(place: "1235", longitude: "w22331", latitude: "+22332.00")
      
        // place test
        let placeError = validator.error(input: LocationInputType.place(location.place))
        assert(placeError != nil && placeError == LocationError.placeIsNumber)
      
        // longitude test
        if let longitude = location.longitude {
          let longitudeError = validator.error(input: LocationInputType.longitude(longitude))
          assert(placeError != nil && longitudeError == LocationError.longitudeWrong)
        }
      
        // latitude test
        if let latitude = location.latitude {
          let latitudeError = validator.error(input: LocationInputType.latitude(latitude))
          assert(placeError != nil && latitudeError == LocationError.latitudeWrong)
        }
    }

    func testWrongCoordinates() {
        let location = Location(place: "Ams2terdam0", longitude: "w22331", latitude: "-223300")
        if let longitude = location.longitude, let latitude = location.latitude {
          assert(latitude.isCoordinate == true)
          assert(longitude.isCoordinate == false)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
