//
//  FirstDemoTests.swift
//  FirstDemoTests
//
//  Created by Rohan Bhale on 08/05/17.
//  Copyright © 2017 RB. All rights reserved.
//

import XCTest
@testable import FirstDemo

class FirstDemoTests: XCTestCase {
    
    var viewController : ViewController!
    
    override func setUp() {
        super.setUp()
        viewController = ViewController()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_NumberOfVowels_WhenPassedDominik_RetunsThree() {
        let string = "Dominik"
        
        let numberOfVowels = viewController.numberOfVowels(in: string)
        
        XCTAssertEqual(numberOfVowels, 3, "Should find 3 vowels in Dominik",file:"FirstDemoTests.swift",line:24)
    }
    
    func test_MakeHeadline_ReturnsStringWithEachWordStartCapital() {
        let input = "this is A test headline"
        let expectedOutput = "This Is A Test Headline"
        
        let actualOutput = viewController.makeHeadline(from: input)
        XCTAssertEqual(actualOutput, expectedOutput)
    }
    
    func test_MakeHeadline_ReturnsStringWithEachWordStartCapital2() {
        let input = "Here is another Example"
        let expectedOutput = "Here Is Another Example"
        let actualOutput = viewController.makeHeadline(from: input)
        
        XCTAssertEqual(actualOutput, expectedOutput)
    }
    
}
