//
//  MassViewController.swift
//  MyCalculator
//
//  Created by Shivam on 01/09/18.
//  Copyright © 2018 Shivam. All rights reserved.
//

import UIKit

class MassViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK:Properties
    @IBOutlet weak var numberLabel2: UILabel!
    @IBOutlet weak var numberLabel1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    
    //MARK:Variables
    let units = ["Kilogramme kg", "Gramme g", "Milligramme mg", "Microgramme µg", "Quintal q"]
    var numbersOnScreen: Double = 0;
    var dotCounter: Double = 0;
    var result: Double = 0;
    var userChoice1 = ""
    var userChoice2 = ""
    
    //MARK:Functions
    @IBAction func Numbers(_ sender: Any) {
        
        if numberLabel1.text?.count == 16 //Fatel Error Nutralizer
        {}
        else{
            numberLabel1.text = numberLabel1.text! + String((sender as AnyObject).tag - 1)
            numbersOnScreen = Double(numberLabel1.text!)!
        }
       
        
    }
    
    
    @IBAction func Buttons(_ sender: UIButton) {
        if sender.tag == 11 //Dot Button
        {
            if dotCounter == 0
            {
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
            numbersOnScreen = Double(numberLabel1.text!)!
        }
        
        else if sender.tag == 14    //Convert button Pressed
        {
            userChoice1 = label.text!
            userChoice2 = label2.text!
            
            convertUnits()
            
            if ceil(result) == result {
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
        
            
            
        }
        
        
        
        
    }
    
    
    
    
    //MARK:Utility Functions
    func allClear() -> Void {
        numberLabel1.text = ""
        numberLabel2.text = ""
        result = 0
        dotCounter = 0
    }
    
    func convertUnits() -> Void
    {
        //UserChoice1 == "Kilogramme kg"
        if userChoice1 == "Kilogramme kg" && userChoice2 == "Kilogramme kg"
        {
            result = numbersOnScreen;
        }
        else if userChoice1 == "Kilogramme kg" && userChoice2 == "Gramme g"
        {
            result = numbersOnScreen * 1000
        }
        else if userChoice1 == "Kilogramme kg" && userChoice2 == "Milligramme mg"
        {
            result = numbersOnScreen * 1000000
        }
         
        else if userChoice1 == "Kilogramme kg" && userChoice2 == "Microgramme µg"
        {
            result = numbersOnScreen * 1000000000
        }
        else if userChoice1 == "Kilogramme kg" && userChoice2 == "Quintal q"
        {
            result = numbersOnScreen * 0.01
        }
            
        //UserChoice1 == "Gramme g"
        else if userChoice1 == "Gramme g" && userChoice2 == "Kilogramme kg"
        {
            result = numbersOnScreen * 0.001
        }
            
        else if userChoice1 == "Gramme g" && userChoice2 == "Gramme g"
        {
            result = numbersOnScreen
        }
        else if userChoice1 == "Gramme g" && userChoice2 == "Milligramme mg"
        {
            result = numbersOnScreen * 1000
        }
        else if userChoice1 == "Gramme g" && userChoice2 == "Microgramme µg"
        {
            result = numbersOnScreen * 1000000
        }
        else if userChoice1 == "Gramme g" && userChoice2 == "Quintal q"
        {
            result = numbersOnScreen * 0.00001
        }
          
        //UserChoice1 == "Milligramme mg"
        else if userChoice1 == "Milligramme mg" && userChoice2 == "Kilogramme kg"
        {
            result = numbersOnScreen * 0.000001
        }
        else if userChoice1 == "Milligramme mg" && userChoice2 == "Gramme g"
        {
            result = numbersOnScreen * 0.001
        }
        else if userChoice1 == "Milligramme mg" && userChoice2 == "Milligramme mg"
        {
            result = numbersOnScreen
        }
        else if userChoice1 == "Milligramme mg" && userChoice2 == "Microgramme µg"
        {
            result = numbersOnScreen * 1000
        }
        else if userChoice1 == "Milligramme mg" && userChoice2 == "Quintal q"
        {
            result = numbersOnScreen * 0.00000001
        }
            
        //UserChoice1 == "Microgramme µg"
        else if userChoice1 == "Microgramme µg" && userChoice2 == "Kilogramme kg"
        {
            result = numbersOnScreen * 0.000000001
        }
        else if userChoice1 == "Microgramme µg" && userChoice2 == "Gramme g"
        {
            result = numbersOnScreen * 0.000001
        }
        else if userChoice1 == "Microgramme µg" && userChoice2 == "Milligramme mg"
        {
            result = numbersOnScreen * 0.001
        }
        else if userChoice1 == "Microgramme µg" && userChoice2 == "Microgramme µg"
        {
            result = numbersOnScreen
        }
        else if userChoice1 == "Microgramme µg" && userChoice2 == "Quintal q"
        {
            result = numbersOnScreen * 0.00000000001
        }
            
        //UserChoice1 == "Quintal q"
        else if userChoice1 == "Quintal q" && userChoice2 == "Kilogramme kg"
        {
            result = numbersOnScreen * 100
        }
        else if userChoice1 == "Quintal q" && userChoice2 == "Gramme g"
        {
            result = numbersOnScreen * 100000
        }
        else if userChoice1 == "Quintal q" && userChoice2 == "Milligramme mg"
        {
            result = numbersOnScreen * 100000000
        }
        else if userChoice1 == "Quintal q" && userChoice2 == "Microgramme µg"
        {
            result = numbersOnScreen * 100000000000
        }
        else if userChoice1 == "Quintal q" && userChoice2 == "Quintal q"
        {
            result = numbersOnScreen
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
