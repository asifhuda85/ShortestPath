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
        let resultStr = "3 1 1"
        vc.calculatePathLength(arr: testArr)
        let testCalculatePath =  vc.calculatePath(p: vc.path)
        XCTAssertEqual(testCalculatePath, resultStr, "Result is not correct")
        
    }
    /**
     This Test case checks when test inputs (Positive and Negative) are given whether CalculatePath function gives the correct shortest path
     */
    func testCalculatePathIfSomeAreNegetive () {
        let testArr = [[2,-3,4,6,8],[4,-1,6,4,8]]
        let resultStr = "1 1 1 2 1"
        vc.calculatePathLength(arr: testArr)
        let testCalculatePath =  vc.calculatePath(p: vc.path)
        XCTAssertEqual(testCalculatePath, resultStr, "Result is not correct")
        
    }

    func testCalculateOutputNormalFLow () {
        let testArr = [[3,4,1,2,8,6],[6,1,8,2,7,4],[5,9,3,9,9,5],[8,4,1,3,2,6],[3,7,2,8,6,4]]
        let testPathLength = 16
        let testPathTaken = "1 2 3 4 4 5"
        let testResult = "Yes"
        let testCalculateOutput =  vc.calculateOutput(cArr: testArr)
        XCTAssertEqual(testPathLength, testCalculateOutput.pathLength, "Result is not correct")
        XCTAssertEqual(testPathTaken, testCalculateOutput.pathTaken, "Result is not correct")
        XCTAssertEqual(testResult, testCalculateOutput.result, "Result is not correct")

    }
    /**
     This Test case checks when test inputs (5X3 matrix with no path <50) is given whether the calculateOutput() function returns the correct PathLength, PathTaken and TestResult as expected
     */
    func testCalculateOutputOutOfRange () {
        let testArr = [[19,10,19,10,19],[21,23,20,19,12],[20,12,20,11,10]]
        let testPathLength = 48
        let testPathTaken = "1 1 1"
        let testResult = "No"
        let testCalculateOutput =  vc.calculateOutput(cArr: testArr)
        XCTAssertEqual(testPathLength, testCalculateOutput.pathLength, "Result is not correct")
        XCTAssertEqual(testPathTaken, testCalculateOutput.pathTaken, "Result is not correct")
        XCTAssertEqual(testResult, testCalculateOutput.result, "Result is not correct")
        
    }
    /**
    This Test case checks when test inputs (1X5 matrix) is given whether the calculateOutput() function returns the correct PathLength, PathTaken and TestResult as expected
    */
    func testCalculateOutputWithOneRow () {
        let testArr = [[5,8,5,3,5]]
        let testPathLength = 26
        let testPathTaken = "1 1 1 1 1"
        let testResult = "Yes"
        let testCalculateOutput =  vc.calculateOutput(cArr: testArr)
        XCTAssertEqual(testPathLength, testCalculateOutput.pathLength, "Result is not correct")
        XCTAssertEqual(testPathTaken, testCalculateOutput.pathTaken, "Result is not correct")
        XCTAssertEqual(testResult, testCalculateOutput.result, "Result is not correct")
        
    }
  
    /**
     This Test case checks when test inputs (5X1 matrix) is given whether the calculateOutput() function returns the correct PathLength, PathTaken and TestResult as expected
     */
    func testCalculateOutputWithOneColumn () {
        let testArr = [[5],[8],[5],[3],[5]]
        let testPathLength = 3
        let testPathTaken = "4"
        let testResult = "Yes"
        let testCalculateOutput =  vc.calculateOutput(cArr: testArr)
        XCTAssertEqual(testPathLength, testCalculateOutput.pathLength, "Result is not correct")
        XCTAssertEqual(testPathTaken, testCalculateOutput.pathTaken, "Result is not correct")
        XCTAssertEqual(testResult, testCalculateOutput.result, "Result is not correct")
        
    }
    /**
     This Test case checks when test inputs (Starting with >50) are given whether the calculateOutput() function returns the correct PathLength, PathTaken and TestResult as expected
     */
    func testCalculateOutputWhenStartPointIsOverRange () {
        let testArr = [[69,10,19,10,19],[51,23,20,19,12],[60,12,20,11,10]]
        let testPathLength = 0
        let testPathTaken = ""
        let testResult = "No"
        let testCalculateOutput =  vc.calculateOutput(cArr: testArr)
        XCTAssertEqual(testPathLength, testCalculateOutput.pathLength, "Result is not correct")
        XCTAssertEqual(testPathTaken, testCalculateOutput.pathTaken, "Result is not correct")
        XCTAssertEqual(testResult, testCalculateOutput.result, "Result is not correct")
        
    }
    
    /**
     This Test case checks when test inputs (Starting with >50) are given whether the calculateOutput() function returns the correct PathLength, PathTaken and TestResult as expected
     */
    func testCalculateOutputWhenOneValueIsOverRange () {
        let testArr = [[60,3,3,6],[6,3,7,9],[5,6,8,3]]
        let testPathLength = 14
        let testPathTaken = "3 1 1 3"
        let testResult = "Yes"
        let testCalculateOutput =  vc.calculateOutput(cArr: testArr)
        XCTAssertEqual(testPathLength, testCalculateOutput.pathLength, "Result is not correct")
        XCTAssertEqual(testPathTaken, testCalculateOutput.pathTaken, "Result is not correct")
        XCTAssertEqual(testResult, testCalculateOutput.result, "Result is not correct")
        
    }
    
    /**
     This Test case checks when test inputs (Negative values) are given whether the calculateOutput() function returns the correct PathLength, PathTaken and TestResult as expected
     */
    func testCalculateOutputWithNegativeInput () {
        let testArr = [[6,3,-5,9],[-5,2,4,10],[3,-2,6,10],[6,-1,-2,10]]
        let testPathLength = 0
        let testPathTaken = "2 3 4 1"
        let testResult = "Yes"
        let testCalculateOutput =  vc.calculateOutput(cArr: testArr)
        XCTAssertEqual(testPathLength, testCalculateOutput.pathLength, "Result is not correct")
        XCTAssertEqual(testPathTaken, testCalculateOutput.pathTaken, "Result is not correct")
        XCTAssertEqual(testResult, testCalculateOutput.result, "Result is not correct")
        
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
