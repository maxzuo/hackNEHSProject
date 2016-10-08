//
//  ViewController.swift
//  WaitUp!
//
//  Created by Max Zuo on 10/8/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PickSchoolViewControllerDelegate {
    
    var schools: Array<String>!

    @IBOutlet weak var studentDriver: UISegmentedControl!
    @IBOutlet weak var schoolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schools = DataHandler.retrieveSchoolNames()
        schools = ["LS", "AB", "CD", "AC"]
        
        DataHandler.updateBusPosition()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PickSchoolViewController {
            destination.delegate = self
        }
        else {
            let defaults = UserDefaults.standard
            
            defaults.set(schoolLabel.text!, forKey: "School")
            
            if studentDriver.selectedSegmentIndex == 0 {
                defaults.set("student", forKey: "User")
            }
            else {
                defaults.set("driver", forKey: "User")
            }
            
        }
    }

}

