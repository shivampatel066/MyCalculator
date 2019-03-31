//
//  SpeedViewController.swift
//  MyCalculator
//
//  Created by Shivam on 02/09/18.
//  Copyright © 2018 Shivam. All rights reserved.
//

import UIKit

class SpeedViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK:Properties
    
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var numberLabel1: UILabel!
    @IBOutlet weak var numberLabel2: UILabel!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var label2: UILabel!
    
    //MARK:Variables
    let units = ["Lightspeed c", "Mach Ma", "Metre per second m/s", "Kilometre per hour km/h", "Kilometre per second km/s", "Knot kn", "Mile per hour mph", "Foot per second fps", "Inch per second ips"]
    let unitsDictionary: [String : Int] = [
        "Lightspeed c" : 0,
        "Mach Ma" : 1,
        "Metre per second m/s" : 2,
        "Kilometre per hour km/h" : 3,
        "Kilometre per second km/s" : 4,
        "Knot kn" : 5,
        "Mile per hour mph" : 6,
        "Foot per second fps" : 7,
        "Inch per second ips" : 8
    ] //Dictionary to store the Units and Respective Numbers
    var numbersOnScreen: Double = 0;
    var dotCounter: Double = 0;
    var result: Double = 0;
    var userChoice1 = ""
    var userChoice2 = ""
    
    let converterMultiplierArray: [[Double]] = [[1, 880965.201, 299792458, 1.07925285e9, 299792.458, 582749918, 670616629, 983571056, 1.18028527e10],
                                                [1.13511862e-6, 1, 340.3, 1225.08, 0.3403, 661.490281, 761.22942, 1116.46982, 13397.6378],
                                                [3.33564095e-9, 0.0029385836, 1, 3.6, 0.001, 1.94384449, 2.23693629, 3.2808399, 39.3700787],
                                                [9.26566931e-10, 0.000816273223, 0.277777778, 1, 0.00027777777, 0.539956803, 0.621371192, 0.911344415, 10.936133],
                                                [3.33564095e-6, 2.9385836, 1000, 3600, 1, 1943.84449, 2236.93629, 3280.8399, 3280.8399],
                                                [1.71600196e-9, 0.00151173801, 0.514444444, 1.852, 0.000514444444, 1, 1.15077945, 1.68780986, 20.2537183],
                                                [1.49116493e-9, 0.00131366441, 0.44704, 1.609344, 0.00044704, 0.868976242, 1, 1.46666667, 17.6],
                                                [1.101670336e-9, 0.000895680282, 0.3048, 1.09728, 0.0003048, 0.592483801, 0.681818182, 1, 12],
                                                [8.47252802e-11, 7.46400235e-5, 0.0254, 0.09144, 2.54e-5, 0.0493736501, 0.0568181818, 0.0833333333, 1]];
    
    
    
    
    
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
