//
//  CurrencyViewController.swift
//  MyCalculator
//
//  Created by Shivam on 27/08/18.
//  Copyright © 2018 Shivam. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
     //MARK:Properties
    @IBOutlet weak var menu: UIButton!
    var myCurrency:[String] = []
    var myValues:[Double] = []
    var activeCurrency:Double = 0;
    //MARK:OBJECTS
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var output: UILabel!
    
    //MARK:PICKER VIEW
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myCurrency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myCurrency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = myValues[row]
    }
    
    
    //MARK:BUTTON Action
    
    @IBAction func convertAction(_ sender: Any) {
        
        
        
        if (input.text != "")
        {
              output.text = String(Double(input.text!)! * activeCurrency)
        }
      
    }
    //MARK:Actions
   
    
    
    //MARK:Functions
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:GETTING DATA
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=6cc6ecea03cae41f586514e9b4cde241")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do{
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            print(rates)
                            for (key, value) in rates
                            {
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                            print (self.myCurrency)
                            print (self.myValues)
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
            self.pickerView.reloadAllComponents()
        }
        task.resume()

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
