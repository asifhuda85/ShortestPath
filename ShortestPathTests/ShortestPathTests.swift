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
    var pair = Pair(len: 0, s: "")
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateInitialViewController() as! ViewController
        self.vc?.viewDidLoad()

    }
    /**
     This Test case checks whether the outlets are present
     */
    func testIBoutlets(){
        guard let outlets = self.vc else {
            XCTAssert(false, "outlets is nil")
            return
        }

        XCTAssertNotNil(outlets.label1, "label1 not present")
        XCTAssertNotNil(outlets.totalArrayList, "totalArrayList Line is not present")
        XCTAssertNotNil(outlets.resultTitleLbl, "resultTitleLbl is not present")
        XCTAssertNotNil(outlets.errorLbl, "errorLbl is not present")
        XCTAssertNotNil(outlets.resetBtn, "resetBtn is not present")
        XCTAssertNotNil(outlets.resultBtn, "resultBtn is not present")
        XCTAssertNotNil(outlets.resultLabel, "resultLabel is not present")
        XCTAssertNotNil(outlets.RCBtn, "RCBtn is not present")
    }
    /**
     This Test case checks when test inputs (all positive) are given whether CalculatePathLength function gives the correct path length
     */
    func testCalculatePathLengthIfPositive () {
        let testArr = [[3,5,6],[4,6,8],[2,7,9]]
        let testResult = 13
        let testCalculatePathLength =  vc.calculatePathLength(arr: testArr)
        XCTAssertEqual(testResult, testCalculatePathLength, "Result is not correct")
        
    }
    /**
     This Test case checks when test inputs (Positive and Negative) are given whether CalculatePathLength function gives the correct path length
     */
    func testCalculatePathLengthIfSomeNegetive () {
        let testArr = [[2,-3,4,6,8],[4,-1,6,4,8]]
        let testResult = 15
        let testCalculatePathLength =  vc.calculatePathLength(arr: testArr)
        XCTAssertEqual(testResult, testCalculatePathLength, "Result is not correct")
        
    }
    /**
     This Test case checks when test inputs (all positive) are given whether CalculatePath function gives the correct shortest path
     */
    func testCalculatePathIfAllPositive () {
        let testArr = [[3,5,6],[4,6,8],[2,7,9]]
        let resultStr = "2 5 6 "
        vc.calculatePathLength(arr: testArr)
        let testCalculatePath =  vc.calculatePath(p: vc.path)
        XCTAssertEqual(testCalculatePath, resultStr, "Result is not correct")
        
    }
    /**
     This Test case checks when test inputs (Positive and Negative) are given whether CalculatePath function gives the correct shortest path
     */
    func testCalculatePathIfSomeAreNegetive () {
        let testArr = [[2,-3,4,6,8],[4,-1,6,4,8]]
        let resultStr = "2 -3 4 4 8 "
        vc.calculatePathLength(arr: testArr)
        let testCalculatePath =  vc.calculatePath(p: vc.path)
        XCTAssertEqual(testCalculatePath, resultStr, "Result is not correct")
        
    }
    /**
     This Test case checks when test inputs (all positive) are given whether CalculatePathLength function gives the correct path length over 50
     */
    func testCalculatePathLengthOutsideRange () {
        let testArr = [[26,28,29],[27,29,29],[27,27,29]]
        var outsideRange = false
        let testCalculatePathLength =  vc.calculatePathLength(arr: testArr)
        if testCalculatePathLength > 50 {
            outsideRange = true
        }
        XCTAssertEqual(true, outsideRange)
        
    }
    /**
     This Test case checks when test inputs (all positive) are given whether CalculatePathLength function gives the correct path length <=50
     */
    func testCalculatePathLengthWithinRange () {
        let testArr = [[3,5,6],[4,6,8],[2,7,9]]
        var withinRange = false
        let testCalculatePathLength =  vc.calculatePathLength(arr: testArr)
        if testCalculatePathLength <= 50 {
            withinRange = true
        }
        XCTAssertEqual(true, withinRange)
    }
    
    /**
     This Test case checks when test inputs (all positive) are given whether the DFS function returns the correct length
     */
    func testPairLenght() {
        
        let testArr = [[3,5,6],[4,6,8],[2,7,9]]
        let i = 1
        let j = 0
        let rows = 3
        let cols = 3
        let p = pair
        let dfs = vc.dfs(a: testArr, p: p, i: i, j: j, rows: rows, cols: cols)
        XCTAssertEqual(dfs.len, 11, "Result is not correct")
        
    }
 
}
