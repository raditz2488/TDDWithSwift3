//
//  InputViewControllerTests.swift
//  ToDo
//
//  Created by Rohan Bhale on 18/06/17.
//  Copyright © 2017 RB. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class InputViewControllerTests: XCTestCase {
    
    var sut : InputViewController!
    var placeMark: MockPlaceMark!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        
        _ = sut.view
        
        sut.titleTextField.text = "Foo"
        sut.itemManager = ItemManager()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasTitleTextField() {
        XCTAssertNotNil(sut.titleTextField)
    }
    
    func test_HasDateTextField() {
        XCTAssertNotNil(sut.dateTextField)
    }
    
    func test_HasLocationTextField() {
        XCTAssertNotNil(sut.locationTextField)
    }
    
    func test_HasAddressTextField() {
        XCTAssertNotNil(sut.addressTextField)
    }
    
    func test_HasDescriptionTextField() {
        XCTAssertNotNil(sut.descriptionTextField)
    }
    
    func test_HasSaveButton() {
        XCTAssertNotNil(sut.saveButton)
    }
    
    func test_Save_UsesGeocoderToGetCoordinateFromAddress() {
        sut.dateTextField.text = "02/22/2016"
        sut.locationTextField.text = "Bar"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Baz"
        
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.save()
        
        placeMark = MockPlaceMark()
        
        let coordinate = CLLocationCoordinate2DMake(37.3316851, -122.0300674)
        placeMark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placeMark], nil)
        
        let item = sut.itemManager?.item(at: 0)
        
        let testItem = ToDoItem(title: "Foo", itemDescription: "Baz", timestamp: 1456079400.0, location: Location(name: "Bar", coordinate: coordinate))
        
        XCTAssertEqual(item, testItem)
    }
    
    func test_Save_ItemWithOnlyItemTitleSucceds() {
        sut.save()
        let item = sut.itemManager?.item(at: 0)
        let testItem = ToDoItem(title: "Foo")
        XCTAssertEqual(item, testItem)
    }
    
    func test_Save_ItemWithTitleAndOnlyLocationNameSucceds() {
        sut.locationTextField.text = "Bar"

        sut.save()
        let item = sut.itemManager?.item(at: 0)
        let testItem = ToDoItem(title: "Foo", itemDescription: nil, timestamp: nil, location: Location(name: "Bar"))
        
        XCTAssertEqual(item, testItem)
    }
    
    func test_SaveButtonHasSaveAction() {
        let saveButton: UIButton = sut.saveButton
        
        guard let actions = saveButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else { XCTFail(); return }
        
        XCTAssertTrue(actions.contains("save"))
    }
}

extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockPlaceMark: CLPlacemark {
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else { return CLLocation() }
            
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
}
