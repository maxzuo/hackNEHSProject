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
    let handler = DataHandler()
    var selectedSchool: String = "No School Selected"

    @IBOutlet weak var schoolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schools = handler.retrieveSchoolNames()
        schools = ["LS", "AB", "CD", "AC"]
        
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
    }
    
    func setSchool() {
        
        print(selectedSchool)
        self.schoolLabel.text = selectedSchool
    }


}

