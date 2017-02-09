//
//  ExtensionViewController.swift
//  ShortestPath
//
//  Created by Md Asif Huda on 2/7/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import Foundation
import UIKit

extension ViewController{

    /**
     This method takes a 2D array - number of rows and number of columns are input by the user.
     The method take the user input, splits it based on space and adds it to the input label "totalArrayList" to show the user the list of inputs entered by User.
     - Parameter: array:[[Int]]
     - Parameter: nROws: Int
     - Parameter: nCols: Int
     - Parameter: numberInput: String
     */
    func numberBtnPressed (array:[[Int]], nROws: Int, nCols:Int, numberInput: String) {
        arr = array
        numberOfRows = nROws
        numberOfColumn = nCols
        // Checks if the array's count is less than number of rows input by the user
        if  arr.count < numberOfRows {
            // Split the user input by space
            let userInputArr = numberInput.components(separatedBy: " ")
            // Checks whether number input total is less or euqal to column the user insert before
            if userInputArr.count  == numberOfColumn {
                errorLbl.text = ""
                var testArray = [Int]()
                
                for row in userInputArr {
                    testArray.append(Int(row)!)
                }
                arr.append(testArray)
                testArray.removeAll()
                numberInputField.text = ""
                label2.text = "Please Insert \(numberOfColumn) numbers perated by space for row \(arr.count+1)"
                // If array count reaches number of rows then the final array is displayed to the user
                if arr.count == numberOfRows {
                    numberInputField.text = ""
                    numberInputField.isUserInteractionEnabled = false
                    submitBtn.isUserInteractionEnabled = false
                    numberInputField.backgroundColor = UIColor.gray
                    var test2 = ""
                    // loop through array to display every row in new line
                    for i in arr {
                        for j in i {
                            test2 += ("\(j) ")
                        }
                        test2 += ("\n")
                    }
                    totalArrayList.text = test2
                    resultBtn.isHidden = false
                    errorLbl.textColor = UIColor.black
                    errorLbl.text = "Input"
                }
            } else {
                // If the number of integers input by the user is less or more than the column size they initially entered, an error message is displayed
                let errorTxt = "Wrong Input"
                errorLbl.text = errorTxt
                errorLbl.textColor = UIColor.red
            }
        }
    }

    /**
     This method takes a 2D array and returns the path length as an integer.
     - Parameter: arr:[[Int]]
     - Returns: Int
     */
    func calculatePathLength(arr: [[Int]]) -> Int {
        let rows  = arr.count
        let cols = arr[0].count
        path = ""
        
        var pathLength = 100
        
        for i in 0..<rows {
            let p = Pair(len: arr[i][0], s: "")
            let ans = dfs(a: arr, p: p, i: i, j: 0, rows: rows, cols: cols)
            let len = ans.len
            if (len < pathLength) {
                pathLength = len
                path = String(ans.path)
                path = "\(path) \(i+1)"
            }
        }
        return pathLength
    }
    
    /**
     This method takes a path string and reverses it.
     - Parameter: p: String
     - Returns: String
     */
    func calculatePath(p: String)->String {
        var reversePath = [String]()
        var p = path
        
        if(path.isEmpty) {
            return ""
        }
        let revString  = p.components(separatedBy: " ")
        p = ""
        
        for rev in revString {
            reversePath.append(rev)
        }
        for i in stride(from: revString.count-1, through: 0, by: -1) {
            p += "\(reversePath[i]) "
        }
        return "\(p.trimmingCharacters(in: .whitespaces))"
    }

    /**
     This method takes a 2D array and returns a tuple consist of result as String, pathLength as Int and pathTaken as String.
     This method checks if path length is more than 50 or not and based on it returns three parameters.
     - Parameter: cArr: [[Int]]
     - Returns: (result: String, pathLength:Int, pathTaken:String)
     */
    func calculateOutput (cArr: [[Int]]) -> (result: String, pathLength:Int, pathTaken:String) {
        arr = cArr
        let pathLength = calculatePathLength(arr: arr)
        let pathTaken = calculatePath(p:path)
        if ( pathLength <= 50) {
            return ("Yes", pathLength, pathTaken.trimmingCharacters(in: .whitespaces))
        } else {
            let trimmedPath = pathTaken.trimmingCharacters(in: .whitespaces)
            let pathIndices  = trimmedPath.components(separatedBy: " ")
            var newPath = ""
            var j = 0
            var newLength = 0
            if(trimmedPath != "") {
                loop: for i in pathIndices {
                    if(newLength + arr[Int(i)! - 1][j] > 50) {
                        break loop
                    }
                    else {
                        newLength += arr[Int(i)! - 1][j]
                        newPath.append(" \(i)")
                    }
                    j += 1
                }
            }
            return ("No", newLength, newPath.trimmingCharacters(in: .whitespaces))
        }
    }
    
    
    /* This method performs a recursive depth-first search to calculate the shortest path length. For each possible starting position (on the left side of the array), the shortest path length from that position is calculated. The minimum of these lengths is returned as the output.
        
        At any point in the array, movement can be done in three directions - top-right, right, and bottom-right. The shortest of these three paths is chosen, and the path lengths for the three is again calculated in a recursive manner. When the algorithm reaches the penultimate column of the array, it simply returns the smallest of the next three elements accessible to it.
        */
    func dfs(a:[[Int]], p: Pair, i: Int, j:Int, rows:Int, cols:Int)-> Pair {
        if(j == cols - 1) {
            return Pair(len: arr[i][j], s: "")
        }
        var s = p.path
        
        //i1, i2 and i3 correspond to the next possible row value that the current path can have.
        var i1 = Int()
        var i2 = Int()
        var i3 = Int()
        
        //Checking for wrap-around, since top and bottom rows are connected
        if(i==0) {
            i1 = rows-1
            if rows == 1 {
                i3 = i
            }else {
                i3 = i+1
            }
        }
        else if(i==rows-1) {
            i1 = i-1
            i3 = 0
        }
        else {
            i1 = i-1
            i3 = i+1
        }
        i2 = i
        
        //For the penultimate column, lowest value from the last column is included.
        if(j>=cols-2) {
            var min = 0
            if(a[i1][j+1]<a[i2][j+1] && a[i1][j+1]<a[i3][j+1]) {
                min = i1
            }
            else if(a[i2][j+1]<a[i1][j+1] && a[i2][j+1]<a[i3][j+1]) {
                min = i2
            }
            else {
                min = i3
            }
            s.append("\(min+1)")
            let len = p.len + a[min][j+1]
            return  Pair(len: len, s: s)
        }
            
        //For other columns, the method is recursively called to find the lowest path from the three possible continuation paths.
        else {
            var p1:Pair = dfs(a: a, p: Pair(len: p.len + a[i1][j+1], s: s ), i: i1, j: j+1, rows: rows, cols: cols)
            var p2:Pair = dfs(a: a, p: Pair(len: p.len + a[i2][j+1], s: s ), i: i2, j: j+1, rows: rows, cols: cols)
            var p3:Pair = dfs(a: a, p: Pair(len: p.len + a[i3][j+1], s: s ), i: i3, j: j+1, rows: rows, cols: cols)
            if(p1.len<p2.len && p1.len<p3.len) {
                p1.path.append(" \(i1+1)")
                return p1
            }
            else if(p2.len<p1.len && p2.len<p3.len) {
                p2.path.append(" \(i2+1)")
                return p2
            }
            else {
                p3.path.append(" \(i3+1)")
                return p3
            }
        }
    }

}
