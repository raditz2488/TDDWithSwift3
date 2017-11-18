//
//  LocationTests.swift
//  ToDo
//
//  Created by Rohan Bhale on 27/05/17.
//  Copyright © 2017 RB. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Init_WhenGivenCoordinate_SetsCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude:1, longitude:2)
        
        let location = Location(name: "", coordinate:coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func test_Init_WhenGivenName_SetsName() {
        let location = Location(name: "Foo")
        XCTAssertEqual(location.name, "Foo", "Should set name")
    }
    
    func test_EqualLocations_AreEqual() {
        let first = Location(name: "Foo")
        let second = Location(name: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func test_Locations_WhenLatitudeDiffers_AreNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLongLat: (1.0, 0.0), secondLongLat: (0.0, 0.0))
    }
    
    func test_Locations_WhenLongitudeDiffers_AreNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLongLat: (0.0, 1.0), secondLongLat: (0.0, 0.0))
    }
    
    func performNotEqualTestWith(firstName: String,
                                 secondName: String,
                                 firstLongLat: (Double, Double)?,
                                 secondLongLat: (Double, Double)?,
                                 line: UInt = #line) {
        var firstCoordinate : CLLocationCoordinate2D? = nil
        if let firstLongLat = firstLongLat {
            firstCoordinate = CLLocationCoordinate2D(latitude: firstLongLat.0, longitude: firstLongLat.1)
        }
        
        let firstLocation = Location(name: firstName, coordinate: firstCoordinate)
        
        var secondCoordinate : CLLocationCoordinate2D? = nil
        if let secondLongLat = secondLongLat {
            secondCoordinate = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
        }
        let secondLocation = Location(name: secondName, coordinate: secondCoordinate)
        XCTAssertNotEqual(firstLocation, secondLocation, line: line)
    }
    
    func test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLongLat: (0.0, 0.0), secondLongLat: nil)
    }
    
    func test_Locations_WhenNamesDiffer_AreNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Bar", firstLongLat: nil, secondLongLat: nil)
    }
    
    func test_CanBeSerializedAndDeserialLized() {
        let location = Location(name: "Home", coordinate: CLLocationCoordinate2DMake(50.0, 6.0))
        let dict = location.plistDict
        XCTAssertNotNil(dict)
        let recreatedLocation = Location(dict:dict)
        XCTAssertEqual(location, recreatedLocation)
    }
}
