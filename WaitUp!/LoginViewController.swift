//
//  ViewController.swift
//  WaitUp!
//
//  Created by Max Zuo on 10/8/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, PickSchoolViewControllerDelegate {
    
    var schools: Array<String>!

    @IBOutlet weak var studentDriver: UISegmentedControl!
    @IBOutlet weak var schoolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let school = defaults.value(forKey: "School") as? NSString {
            schoolLabel.text = school as String
        }
        
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("School_Names").observe(.value) { (snap: FIRDataSnapshot) in
            
            print("Retrieving school names")
            self.schools = ((snap.value! as! NSArray)[1] as! String).components(separatedBy: "\t")
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("This is schools: \(schools)")
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

