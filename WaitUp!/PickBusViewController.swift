//
//  PickBusViewController.swift
//  WaitUp!
//
//  Created by Max Zuo on 10/8/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit

class PickBusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var busTableView: UITableView!
    var buses: Array<String>! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let schoolInfo = DataHandler.retrieveSchoolInfo()
        
        let lines = schoolInfo?.components(separatedBy: "\n")
        
        for line in lines! {
            let name = line.components(separatedBy: "\t")
            if name.count >= 1 {
                buses.append(name[0])
            }
        }*/

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
        
    }

}
