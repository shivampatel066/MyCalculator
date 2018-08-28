//
//  ViewController.swift
//  MyCalculator
//
//  Created by Shivam on 16/07/18.
//  Copyright © 2018 Shivam. All rights reserved.
//

import UIKit

var temp1: String = ""
var temp2: String = ""
var temp3: String = ""
var tempNumberBeforeOpeatorPressed :Double = 0
var tempNumberAfterOperatorPressed :Double = 0
var tempIntNumberBeforeOperatorPressed :Int = 0
var tempIntNumberAfterOperatorPressed :Int = 0
var tempPerformingMath = false
var tempResult :Double = 0
var tempOperation = 0
var tempLabel3EqualSign = false
var tempLabel2HasOperator = false
var tempIntResult = 0
var tempEqualIsPressed = false
var tempPerformingMathCounter = 0



class ViewController: UIViewController {
    
    
    //MARK:Properties
    var numberBeforeOperatorPressed :Double = 0
    var numberAfterOperatorPressed :Double = 0
    var intNumberBeforeOperatorPressed :Int = 0
    var intNumberAfterOperatorPressed :Int = 0
    var performingMath = false
    var performingMathCounter = 0
    var result :Double = 0
    var operation = 0
    var label3EqualSign = false
    var label2HasOperator = false
    var intResult = 0
    var equalIsPressed = false
    var subStringForSavingPreviousNumbers :String = ""
    var text = ""
    
    
    
    
    
    
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    
    
    
    //MARK: UIActions
    //MARK: Numbers
    @IBAction func numbers(_ sender: UIButton)
    {
        if equalIsPressed == true
        {
            allClear()
        }
        if performingMath {
            label2.text = label2.text! + String(sender.tag - 1)
            text = label2.text!
            let index = text.index(text.startIndex, offsetBy: 1)
            subStringForSavingPreviousNumbers = String(text[index...])
            numberAfterOperatorPressed = Double(subStringForSavingPreviousNumbers)!
           // numberAfterOperatorPressed = (numberAfterOperatorPressed * 10) + Double(sender.tag - 1)
            calculateAndDisplay()
        }
            
        else
        {
            if !label3EqualSign
            {
                label3.text = "= " + label3.text! + String(sender.tag - 1)
                label3EqualSign = true
            }
            else
            {
                label3.text = label3.text! + String(sender.tag - 1)
            }
            label2.text = label2.text! + String(sender.tag - 1)
        }
        
    }
    //MARK: Buttons
    @IBAction func buttons(_ sender: UIButton)
    {
        
       
        if label2.text != "" && (sender.tag == 14 || sender.tag == 15 || sender.tag == 16 || sender.tag == 17) //Only +-/*
        {
            
            if !label2HasOperator {
                numberBeforeOperatorPressed = Double(label2.text!)!
                performingMath = true
                
                
            }
            
            label2HasOperator = true
            equalIsPressed = false
            switch sender.tag
            {
            case 14: operatorPressedDisplay(op: "÷")//divide
                
            case 15: operatorPressedDisplay(op: "x")//multiply
                
            case 16: operatorPressedDisplay(op: "-")//minus
                
            case 17: operatorPressedDisplay(op: "+")//add
                
            default: label2.text = "error" //just to remove error
            }
            operation = sender.tag
        }
            
        else if sender.tag == 18  //Equal Button Pressed
        {  equalIsPressed = true
            label2.font = UIFont(name:"Helvetica-Light", size: 40.0)
            label2.textColor = UIColor.lightGray
            label3.font = UIFont(name:"Helvetica-Light", size: 60.0)
            label3.textColor = UIColor.white
        }
            
        else if sender.tag == 11    //Clear button pressed
        {
            allClear()
        }
        else if sender.tag == 12    //delete button Pressed
        {
            
            label3EqualSign = false
            
            label2.text = String(label2.text!.dropLast())
            
            if performingMath == false // delete before operator pressed
            {
                
                if label2.text == ""
                {
                    allClear()
                    label3EqualSign = true
                }
                
                if !label3EqualSign
                {
                    label3.text = "= " + label2.text!
                    label3EqualSign = true
                }
                else
                {
                    label3.text = label2.text!
                    label3EqualSign = false
                }
            }
            else //delete After Operator Pressed
            {
                
                
                if label2.text == ""
                {
                    performingMath = false
                    label2HasOperator = false
                    operation = 0
                    
                    label2.text = label1.text
                    label1.text = ""
                    
                    if !label3EqualSign
                    {
                        label3.text = "= " + label2.text!
                        label3EqualSign = true
                    }
                    else
                    {
                        label3.text = label2.text!
                        label3EqualSign = false
                    }
                }
                
                else if label2.text == "x"||label2.text == "-"||label2.text == "+"||label2.text == "÷"
                {
                    if !label3EqualSign
                    {
                        label3.text = "= " + label1.text!
                        label3EqualSign = true
                    }
                    else
                    {
                        label3.text = label1.text!
                        label3EqualSign = false
                    }
                    
                }
                else
                {
                    text = label2.text!
                    let index = text.index(text.startIndex, offsetBy: 1)
                    subStringForSavingPreviousNumbers = String(text[index...])
                    numberAfterOperatorPressed = Double(subStringForSavingPreviousNumbers)!
                   
                    calculateAndDisplay()
                    
                }
                
            }
        }
            
        else if sender.tag == 19 //Decimal Button
        {
            label2.text = label2.text! + "."
            if performingMath == false
            {
                label3.text = label3.text! + "."
            }
            
        }
        else if sender.tag == 13 //Percentage Button Pressed
        {
            if performingMath
            {
                if numberAfterOperatorPressed == 0
                {
                }
                else
                {
                    if operation == 16 //Sub
                    {
                        label2.text = "-" + String((numberBeforeOperatorPressed * numberAfterOperatorPressed) / 100)
                        numberAfterOperatorPressed = (numberBeforeOperatorPressed * numberAfterOperatorPressed) / 100
                        calculateAndDisplay()
                    }
                    else if operation == 17 //Add
                    {
                        label2.text = "+" + String((numberBeforeOperatorPressed * numberAfterOperatorPressed) / 100)
                        numberAfterOperatorPressed = (numberBeforeOperatorPressed * numberAfterOperatorPressed) / 100
                        calculateAndDisplay()
                        
                    }
                    else if operation == 15 //multy
                    {
                        label2.text = "x" + String(numberAfterOperatorPressed / 100)
                        numberAfterOperatorPressed = numberAfterOperatorPressed / 100
                        calculateAndDisplay()
                    }
                    else if operation == 14 //Divide
                    {
                        label2.text = "÷" + String(numberAfterOperatorPressed / 100)
                        numberAfterOperatorPressed = numberAfterOperatorPressed / 100
                        calculateAndDisplay()
                    }
                }
            }
            else
            {
                let percentageString = label2.text!
                let percentage = Double(percentageString)! / 100
                label2.text = String(percentage)
                label3.text = label2.text!
            }
        }
        
        
        
    }
    //MARK:Navigation Controll Functions
    
    
    
    
    
    
    //MARK:Utility Functions
    func allClear() -> Void {
        label1.text = ""
        label2.text = ""
        label3.text = ""
        label3EqualSign = false
        label2HasOperator = false
        performingMath = false
        performingMathCounter = 0
        result = 0
        numberBeforeOperatorPressed = 0
        numberAfterOperatorPressed = 0
        equalIsPressed = false
        
        intNumberBeforeOperatorPressed = 0
        label3.font = UIFont(name:"Helvetica-Light", size: 40.0)
        label3.textColor = UIColor.gray
        label2.font = UIFont(name:"Helvetica-Light", size: 70.0)
        label2.textColor = UIColor.white
        
        
        
    }
    
    func operatorPressedDisplay(op :String) -> Void
    {
        if ceil(numberBeforeOperatorPressed) == numberBeforeOperatorPressed {
            intNumberBeforeOperatorPressed = Int(numberBeforeOperatorPressed)
            label1.text = String(intNumberBeforeOperatorPressed)
        }
        else
        {
            label1.text = String(numberBeforeOperatorPressed)
        }
        label2.text = op
        performingMathCounter = performingMathCounter + 1
        
        if performingMathCounter > 1
        {
            
            text = label3.text!
            let index1 = text.index(text.startIndex, offsetBy: 2)
            label1.text = String(text[index1...])
            numberBeforeOperatorPressed = Double(String(text[index1...]))!
            numberAfterOperatorPressed = 0
            calculateAndDisplay()
        }
    }
    
    func calculateAndDisplay() -> Void {
        switch operation
        {
        case 14: result = numberBeforeOperatorPressed / numberAfterOperatorPressed //Divide
            
        case 15: result = numberBeforeOperatorPressed * numberAfterOperatorPressed //Multy
            
        case 16: result = numberBeforeOperatorPressed - numberAfterOperatorPressed //Sub
            
        case 17: result = numberBeforeOperatorPressed + numberAfterOperatorPressed //Add
            
        default:
            label3.text = "Error"
        }
        if ceil(result) == result {
            intResult = Int(result)
            label3.text = "= " + String(intResult)
        }
        else
        {
            label3.text = "= " + String(result)
        }
        
    }
    
  
    func applyRoundCorner(_ Object:AnyObject)
    {
        Object.layer.cornerRadius = Object.frame.size.width / 2
        Object.layer.masksToBounds = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        temp1 = label1.text!
        temp2 = label2.text!
        temp3 = label3.text!
        tempLabel3EqualSign = label3EqualSign
        tempLabel2HasOperator = label2HasOperator
        tempPerformingMath = performingMath
        tempPerformingMathCounter = performingMathCounter
        tempResult = result
        tempIntResult = intResult
        tempNumberBeforeOpeatorPressed =  numberBeforeOperatorPressed
        tempNumberAfterOperatorPressed = numberAfterOperatorPressed
        tempIntNumberBeforeOperatorPressed = intNumberBeforeOperatorPressed
        tempIntNumberAfterOperatorPressed = intNumberAfterOperatorPressed
        tempOperation = operation
        tempEqualIsPressed = equalIsPressed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.applyRoundCorner(menu)
        
        label1.text = temp1
        label2.text = temp2
        label3.text = temp3
        label3EqualSign = tempLabel3EqualSign
        label2HasOperator = tempLabel2HasOperator
        performingMath = tempPerformingMath
        performingMathCounter = tempPerformingMathCounter
        result = tempResult
        intResult = tempIntResult
        numberBeforeOperatorPressed = tempNumberBeforeOpeatorPressed
        numberAfterOperatorPressed = tempNumberAfterOperatorPressed
        intNumberBeforeOperatorPressed = tempIntNumberBeforeOperatorPressed
        intNumberAfterOperatorPressed = tempIntNumberAfterOperatorPressed
        operation = tempOperation
        equalIsPressed = tempEqualIsPressed
        
        if equalIsPressed == true
        {
            label2.font = UIFont(name:"Helvetica-Light", size: 40.0)
            label2.textColor = UIColor.lightGray
            label3.font = UIFont(name:"Helvetica-Light", size: 60.0)
            label3.textColor = UIColor.white
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

