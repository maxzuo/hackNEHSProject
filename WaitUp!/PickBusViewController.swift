//
//  PickBusViewController.swift
//  WaitUp!
//
//  Created by Max Zuo on 10/8/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


protocol NavigationViewControllerDelegate {
}

class PickBusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var busTableView: UITableView!
    var buses: Array<String>! = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve selected school name.
        
        let defaults = UserDefaults.standard
        let schoolName = defaults.value(forKey: "School") as? NSString as! String
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 206, green: 73, blue: 226, alpha: 1.0)
        
        //var schoolInfo: String?
        
        appDelegate.databaseRef.child(schoolName).observe(.value) { (snap: FIRDataSnapshot) in
            print(snap.value!)
            let busesDictionary = (snap.value! as! NSDictionary) as! Dictionary<String, String>
            self.buses = Array(busesDictionary.keys)
            
            print(self.buses)
            
            self.busTableView.reloadData()
            
        }

        busTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = buses[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let defaults = UserDefaults.standard
        defaults.set(buses[indexPath.row], forKey: "Bus")

        if UserDefaults.standard.value(forKey: "User") as? NSString == "student" {
            performSegue(withIdentifier: "StudentMapSegue", sender: nil)
        }
        else {
            performSegue(withIdentifier: "DriverMapSegue", sender: nil)
        }
        
    }

    @IBAction func cancelSelectBus() {
        performSegue(withIdentifier: "SelectBus", sender: nil)
    }
}
