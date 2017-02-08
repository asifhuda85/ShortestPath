//
//  ViewController.swift
//  ShortestPath
//
//  Created by Md Asif Huda on 2/6/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var totalArrayList: UILabel!
    @IBOutlet weak var resultTitleLbl: UILabel!
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
    var check = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        textField1.delegate = self
        numberInputField.delegate = self
        textField1.keyboardType = .numberPad
        numberInputField.keyboardType = .numbersAndPunctuation

    }
    /**
     This method checks whether the textfield input contains the character mentioned in the character set.
     If it matches it allows the input or else it will not take the input.
     Here there are two text fields, one allows spaces in the input, while the other does not.
     A bool check is done to enforce this validation.
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if check == false {
            let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
            return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
            
        }else {
            let invalidCharacters = CharacterSet(charactersIn: "-0123456789 ").inverted
            return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
        }
    }
    
    /**
     This IBAction take user input. If the user input is valid then it calls the numberBtnPressed function.
     */
    @IBAction func numberSubmitBtnPressed() {
        guard let userInput:String = numberInputField.text else {
            return
        }
        numberBtnPressed(array: arr, nROws: numberOfRows, nCols: numberOfColumn, numberInput: userInput )
    }
    
    /**
     This IBAction checks the path length.
     If the path length is less or equal to 50 then it shows the user the path length and the path itself.
     If the path length is more than 50 then it shows a message to that effect.
     */
    @IBAction func resultButton() {
        resultTitleLbl.text = "Output"
        let pathLength = calculatePathLength(arr: arr)
        if ( pathLength <= 50) {
            resultLabel.text = "Shortest Path length is \(calculatePathLength(arr: arr))\n \n Path is \(calculatePath(p:path))"
        } else {
            resultLabel.text = "Shortest Path length is more than 50"
        }
        resultBtn.isHidden = true
        resetBtn.isHidden = false
    }
    
    /**
     This IBAction only takes care of user input for number of rows and Number of columns.
     This function converts the user input and checks whether it is within the allowed range
     If it is then it is stored as numberOfRows or numberOfColumns.
     Otherwise, an alert is given to the user to prompt input within the allowed range.
     */
    
    @IBAction func sumbitBtn() {
        if (label1.text?.contains("Rows"))!{
            let rowInput = textField1.text
            guard let nRow = Int(rowInput!)  else {
                return
            }
            // checks whether the number of row input is between 1-10
            if nRow < 11 && nRow > 0 {
                label1.textColor = UIColor.black
                numberOfRows = nRow
                label1.text = "Insert Number of Columns between 5-10"
                textField1.text = ""
            }else {
                // If the input is outside range show red text
                label1.textColor = UIColor.red
                print("\(nRow) is not valid")
            }
        } else {
            let columnInput = textField1.text
            guard let nColumn = Int(columnInput!)  else {
                return
            }
            // checks whether the number of columns input is between 5-10
            if nColumn <= 10 && nColumn >= 5 {
                label2.text = "Please Insert \(nColumn) numbers perated by space for row 1"
                label1.textColor = UIColor.black
                numberOfColumn = nColumn
                check = true
                textField1.text = ""
                textField1.isUserInteractionEnabled = false
                textField1.backgroundColor = UIColor.gray
                RCBtn.isUserInteractionEnabled  = false
                numberInputField.isUserInteractionEnabled = true
                
            } else {
                // If the input is outside range show red text
                label1.textColor = UIColor.red
                print("\(nColumn) is not valid")
            }
        }
    }
    
    /**
     This IBAction resets all the counts, removes all the results and resets the app to its original state
     to perform the calculation again without relaunching the app.
     */
    @IBAction func resetBtnTapped(_ sender: AnyObject) {
        numberOfRows = 0
        numberOfColumn = 0
        arr = [[Int]]()
        totalArrayList.text = ""
        resultLabel.text = ""
        resultTitleLbl.text = ""
        errorLbl.text = ""
        label2.text = "Please Insert numbers perated by space for row 1"
        label1.text = "Insert Number of Rows between 1-10"
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

    
}
