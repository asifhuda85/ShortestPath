//
//  ShortestPathTests.swift
//  ShortestPathTests
//
//  Created by Md Asif Huda on 2/6/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import XCTest
@testable import ShortestPath

class ShortestPathTests: XCTestCase {
    
    var vc: ViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateInitialViewController() as! ViewController
    }
    
    func testCalculatePathLength () {
        let testArr = [[3,5,6],[4,6,8],[2,7,9]]
        let testResult = "13"
        let testCalculatePathLength =  vc.calculatePathLength(arr: testArr)
        XCTAssertEqual(testResult, testCalculatePathLength, "Result is not correct")
        
    }
    
    func testCalculatePath () {
        let testArr = [[3,5,6],[4,6,8],[2,7,9]]
        let resultStr = "2 5 6 "
        vc.calculatePathLength(arr: testArr)
        let testCalculatePath =  vc.calculatePath(p: vc.path) 
        XCTAssertEqual(testCalculatePath, resultStr, "Result is not correct")

    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
