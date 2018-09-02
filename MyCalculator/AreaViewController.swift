//
//  AreaViewController.swift
//  MyCalculator
//
//  Created by Shivam on 02/09/18.
//  Copyright © 2018 Shivam. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK:Properties
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var numberLabel2: UILabel!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var numberLabel1: UILabel!

    //MARK:Variables
    let units = ["Square metre m²", "Square decimetre dm²", "Square centimetre cm²", "Square millimetre mm²", "Square micron µm²"]
    let unitsDictionary: [String : Int] = [
        "Square metre m²" : 0,
        "Square decimetre dm²" : 1,
        "Square centimetre cm²" : 2,
        "Square millimetre mm²" : 3,
        "Square micron µm²" : 4
        ] //Dictionary to store the Units and Respective Numbers
    var numbersOnScreen: Double = 0;
    var dotCounter: Double = 0;
    var result: Double = 0;
    var userChoice1 = ""
    var userChoice2 = ""
    
    let converterMultiplierArray: [[Double]] = [[1, 100, 10000, 1000000, 1e12],
                                                [0.01, 1, 100, 10000, 1e10],
                                                [0.0001, 0.01, 1, 100, 100000000],
                                                [1e-6, 0.0001, 0.01, 1, 1000000],
                                                [1e-12, 1e-10, 1e-8, 1e-6, 1]];
                                               
    
    
    
    
    
    //2D Array to Store the Conversion Multipliers.
    
    
    @IBAction func Numbers(_ sender: UIButton) {
        if numberLabel1.text?.count == 16 //Fatel Error Nutralizer
        {}
        else{
            numberLabel1.adjustsFontSizeToFitWidth = true
            numberLabel1.minimumScaleFactor = 0.2
            numberLabel1.text = numberLabel1.text! + String((sender as AnyObject).tag - 1)
            numbersOnScreen = Double(numberLabel1.text!)!
        }
    }
    
    
    @IBAction func Buttons(_ sender: UIButton) {
        
        if sender.tag == 11 //Dot Button
        {
            if dotCounter == 0
            {
                numberLabel1.adjustsFontSizeToFitWidth = true
                numberLabel1.minimumScaleFactor = 0.2
                numberLabel1.text = numberLabel1.text! + "."
                dotCounter = dotCounter+1;
            }
            else{
                
            }
        }
            
        else if sender.tag == 12 //AC button pressed
        {
            allClear()
        }
            
        else if sender.tag == 13    //delete button Pressed
        {
            if numberLabel1.text?.last == "."
            {
                dotCounter = 0;
            }
            numberLabel1.text = String(numberLabel1.text!.dropLast())
            
            if numberLabel1.text == ""
            {
                allClear()
            }
            else {
                numbersOnScreen = Double(numberLabel1.text!)!
            }
        }
            
        else if sender.tag == 14    //Convert button Pressed
        {
            userChoice1 = label.text!
            userChoice2 = label2.text!
            
            
            
            convertUnits()
            
            if ceil(result) == result && result < 5.5589984565e+18 //To Nutralise Fatel Error number bigger than Int.max while converting.
            {
                
                
                numberLabel2.text = String(Int(result))
                
                if (numberLabel2.text?.count)! >= 13
                {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .scientific
                    formatter.positiveFormat = "0.########E0"
                    formatter.exponentSymbol = "e"
                    if let scientificFormatted = formatter.string(for: result) {
                        numberLabel2.text = scientificFormatted  // "5e+2"
                    }
                    
                }
            }
            else
            {
                numberLabel2.text = String(result)
                if (numberLabel2.text?.count)! >= 13
                {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .scientific
                    formatter.positiveFormat = "0.########E0"
                    formatter.exponentSymbol = "e"
                    if let scientificFormatted = formatter.string(for: result) {
                        numberLabel2.text = scientificFormatted  // "5e+2"
                    }
                }
            }
            
            numberLabel2.adjustsFontSizeToFitWidth = true
            numberLabel2.minimumScaleFactor = 0.2
            
        }
        
    }
    
    //MARK:Utility Functions
    func allClear() -> Void {
        numberLabel1.text = ""
        numberLabel2.text = ""
        result = 0
        dotCounter = 0
        numbersOnScreen = 0
    }
    
    func convertUnits() -> Void
    {
        print(userChoice1)
        print(userChoice2)
        result = numbersOnScreen * converterMultiplierArray[unitsDictionary[userChoice1]!][unitsDictionary[userChoice2]!]
        
        
        
    }
    
    func applyRoundCorner(_ Object:AnyObject)
    {
        Object.layer.cornerRadius = Object.frame.size.width / 2
        Object.layer.masksToBounds = true
    }
    
    //PICKERVIEW
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        label.text = units[row]
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return units[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return units.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView2 {
            label2.text = units[row]
        } else if pickerView == pickerView{
            //pickerView2
            label.text = units[row]
        }
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyRoundCorner(menu)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
