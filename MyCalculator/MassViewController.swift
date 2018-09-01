//
//  MassViewController.swift
//  MyCalculator
//
//  Created by Shivam on 01/09/18.
//  Copyright © 2018 Shivam. All rights reserved.
//

import UIKit

class MassViewController: UIViewController {
    
    @IBOutlet weak var menu: UIButton!
    //MARK:Functions
    func applyRoundCorner(_ Object:AnyObject)
    {
        Object.layer.cornerRadius = Object.frame.size.width / 2
        Object.layer.masksToBounds = true
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
