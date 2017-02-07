//
//  ViewController.swift
//  ShortestPath
//
//  Created by Md Asif Huda on 2/6/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var totalArrayList: UILabel!

    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var resultBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var RCBtn: UIButton!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var numberInputField: UITextField!
    @IBOutlet weak var label2: UILabel!
    var numberOfRows = 0
    var numberOfColumn = 0
    var arr = [[Int]]()
    var path = ""


    @IBAction func resetBtnTapped(_ sender: AnyObject) {
            numberOfRows = 0
            numberOfColumn = 0
            arr = [[Int]]()
            totalArrayList.text = ""
            resultLabel.text = ""
            label2.text = "Please Insert numbers perated by space for row 1"
            label1.text = "Insert Number of Rows"
            textField1.text = ""
            textField1.isUserInteractionEnabled = true
            textField1.backgroundColor = UIColor.white
            RCBtn.isUserInteractionEnabled  = true
            numberInputField.isUserInteractionEnabled = true
            submitBtn.isUserInteractionEnabled = true
            numberInputField.backgroundColor = UIColor.white
            resultBtn.isHidden = true
            resetBtn.isHidden = true
            numberInputField.isUserInteractionEnabled = false
    }
    
    @IBAction func numberSubmitBtnPressed() {
        guard let userInput:String = numberInputField.text else {
            return
        }
     numberBtnPressed(array: arr, nROws: numberOfRows, nCols: numberOfColumn, numberInput: userInput )
    }
    
    func numberBtnPressed (array:[[Int]], nROws: Int, nCols:Int, numberInput: String) {
        arr = array
        numberOfRows = nROws
        numberOfColumn = nCols
        
//        numberInputField.text = numberInput
        if  arr.count < numberOfRows {
//
            let userInputArr = numberInput.components(separatedBy: " ")
            if userInputArr.count  == numberOfColumn {
                errorLbl.text = ""
                var testArray = [Int]()
                
                for row in userInputArr {
                    testArray.append(Int(row)!)
                }
                arr.append(testArray)
                testArray.removeAll()
                numberInputField.text = ""
                label2.text = "Please Insert numbers perated by space for row \(arr.count+1)"
                
                if arr.count == numberOfRows {
                    numberInputField.text = ""
                    numberInputField.isUserInteractionEnabled = false
                    submitBtn.isUserInteractionEnabled = false
                    numberInputField.backgroundColor = UIColor.gray
                    //            totalArrayList.text = "\(numberOfArray)"
                    var test2 = ""
                    for i in arr {
                        for j in i {
                            test2 += ("\(j) ")
                        }
                        test2 += ("\n")
                    }
                    totalArrayList.text = test2
                    resultBtn.isHidden = false
                    
                }
            } else {
                let errorTxt = "Wrong Input"
                errorLbl.text = errorTxt
                errorLbl.textColor = UIColor.red
            }
            
        }
    }
    
    @IBAction func resultButton(_ sender: AnyObject) {
        
        let pathLength = calculatePathLength(arr: arr)

        if ( pathLength <= 50) {
            resultLabel.text = "Shortest Path length is \(calculatePathLength(arr: arr))\n \n Path is \(calculatePath(p:path))"

        } else {
            resultLabel.text = "Shortest Path length is more than 50)"
            
        }
        


//        resultLabel.text = "Shortest Path length is \(calculatePathLength(arr: arr))\n \n Path is \(calculatePath(p:path))"
        resetBtn.isHidden = false
    }
    
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
                path = "\(path) \(arr[i][0])"
            }
        }
        
        if (pathLength > 50) {
            return 51
        } else {
            return pathLength
        }
        
    }
 
    func calculatePath(p: String)->String {
        var reversePath = [String]()
        var p = path
        
        let revString  = p.components(separatedBy: " ")
        p = ""

        for rev in revString {
            reversePath.append(rev)
        }
        for i in stride(from: revString.count-1, through: 0, by: -1) {
            p += "\(reversePath[i]) "
        }
            return "\(p)"
    }

  
    @IBAction func sumbitBtn() {
        if (label1.text?.contains("Rows"))!{
            let rowInput = textField1.text
            guard let nRow = Int(rowInput!)  else {
                return
            }
            numberOfRows = nRow
            label1.text = "Insert Number of Columns"
            textField1.text = ""
            print(numberOfRows)
        } else {
            let columnInput = textField1.text
            guard let nColumn = Int(columnInput!)  else {
                return
            }
            numberOfColumn = nColumn
            print(numberOfColumn)
            textField1.text = ""
            textField1.isUserInteractionEnabled = false
            textField1.backgroundColor = UIColor.gray
            RCBtn.isUserInteractionEnabled  = false
            numberInputField.isUserInteractionEnabled = true
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dfs(a:[[Int]], p: Pair, i: Int, j:Int, rows:Int, cols:Int)-> Pair {
        var s = p.path
        
        if (p.len > 50) {
            return p
        }

        var i1 = Int()
        var i2 = Int()
        var i3 = Int()
        
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
            s.append("\(a[min][j+1])")
            let len = p.len + a[min][j+1]
            return  Pair(len: len, s: s)
        }
        else {
            var p1:Pair = dfs(a: a, p: Pair(len: p.len + a[i1][j+1], s: s ), i: i1, j: j+1, rows: rows, cols: cols)
            var p2:Pair = dfs(a: a, p: Pair(len: p.len + a[i2][j+1], s: s ), i: i2, j: j+1, rows: rows, cols: cols)
             var p3:Pair = dfs(a: a, p: Pair(len: p.len + a[i3][j+1], s: s ), i: i3, j: j+1, rows: rows, cols: cols)
                if(p1.len<p2.len && p1.len<p3.len) {
                    p1.path.append(" \(a[i1][j+1])")
                    return p1
                }
                    else if(p2.len<p1.len && p2.len<p3.len) {
                        p2.path.append(" \(a[i2][j+1])")
                        return p2
                    }
                    else {
                        p3.path.append(" \(a[i3][j+1])")
                        return p3
                    }
                }
        }

}
