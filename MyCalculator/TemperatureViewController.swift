//
//  TemperatureViewController.swift
//  MyCalculator
//
//  Created by Shivam on 02/09/18.
//  Copyright © 2018 Shivam. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    //MARK:Properties
    
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var pickerView2: UIPickerView!
    
    @IBOutlet weak var numberLabel2: UILabel!
    @IBOutlet weak var numberLabel1: UILabel!
    
    
    
    //MARK:Variables
    let units = ["Celsius °C", "Fahrenheit °F", "Kelvin K", "Rankine °R", "Réaumur °Re"]
   
    var numbersOnScreen: Double = 0;
    var dotCounter: Double = 0;
    var result: Double = 0;
    var userChoice1 = ""
    var userChoice2 = ""
    
  
    
    
    
    
    
    
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
        //UserChoice1 == "Celsius °C"
        if userChoice1 == "Celsius °C"
        {
            if userChoice2 == "Celsius °C"
            {
            result = numbersOnScreen;
            }
            else if userChoice2 == "Fahrenheit °F"
            {
            result = (numbersOnScreen * 1.8) + 32
            }
            else if userChoice2 == "Kelvin K"
            {
            result = numbersOnScreen + 273.15
            }
            else if userChoice2 == "Rankine °R"
            {
            result = (numbersOnScreen + 273.15) * 1.8
            }
            else if userChoice2 == "Réaumur °Re"
            {
            result = numbersOnScreen * 0.8
            }
        }
        //UserChoice1 == "Fahrenheit °F"
        if userChoice1 == "Fahrenheit °F"
        {
            if userChoice2 == "Celsius °C"
            {
                result = (numbersOnScreen - 32) / 1.8;
            }
            else if userChoice2 == "Fahrenheit °F"
            {
                result = numbersOnScreen
            }
            else if userChoice2 == "Kelvin K"
            {
                result = (numbersOnScreen + 459.67) / 1.8
            }
            else if userChoice2 == "Rankine °R"
            {
                result = numbersOnScreen + 459.67
            }
            else if userChoice2 == "Réaumur °Re"
            {
                result = (numbersOnScreen - 32) / 2.25
            }
        }
         //UserChoice1 == "Kelvin K"
        if userChoice1 == "Kelvin K"
        {
            if userChoice2 == "Celsius °C"
            {
                result = numbersOnScreen - 273.15;
            }
            else if userChoice2 == "Fahrenheit °F"
            {
                result = (numbersOnScreen * 1.8) - 459.67
            }
            else if userChoice2 == "Kelvin K"
            {
                result = numbersOnScreen
            }
            else if userChoice2 == "Rankine °R"
            {
                result = numbersOnScreen * 1.8
            }
            else if userChoice2 == "Réaumur °Re"
            {
                result = (numbersOnScreen - 273.15) * 0.8
            }
        }
            //UserChoice1 == "Rankine °R"
        if userChoice1 == "Rankine °R"
        {
            if userChoice2 == "Celsius °C"
            {
                result = (numbersOnScreen - 32 - 459.67) / 1.8;
            }
            else if userChoice2 == "Fahrenheit °F"
            {
                result = numbersOnScreen - 459.67
            }
            else if userChoice2 == "Kelvin K"
            {
                result = numbersOnScreen / 1.8
            }
            else if userChoice2 == "Rankine °R"
            {
                result = numbersOnScreen
            }
            else if userChoice2 == "Réaumur °Re"
            {
                result = (numbersOnScreen - 491.67) / 2.25
            }
        }
            
            //UserChoice1 == "Réaumur °Re"
        if userChoice1 == "Réaumur °Re"
        {
            if userChoice2 == "Celsius °C"
            {
                result = numbersOnScreen * 1.25
            }
            else if userChoice2 == "Fahrenheit °F"
            {
                result = (numbersOnScreen * 2.25) + 32
            }
            else if userChoice2 == "Kelvin K"
            {
                result = (numbersOnScreen * 1.25) + 273.15
            }
            else if userChoice2 == "Rankine °R"
            {
                result = (numbersOnScreen * 2.25) + 32 + 459.67
            }
            else if userChoice2 == "Réaumur °Re"
            {
                result = numbersOnScreen
            }
        }
        
        
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
