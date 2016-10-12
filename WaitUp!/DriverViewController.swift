//
//  DriverViewController.swift
//  WaitUp!
//
//  Created by Max Zuo on 10/10/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase

class DriverViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let bus = UserDefaults.standard.value(forKey: "Bus") as? NSString as! String
    let school = UserDefaults.standard.value(forKey: "School") as? NSString as! String
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let x = Double((location?.coordinate.latitude)!)
        let y = Double((location?.coordinate.longitude)!)
        
        //Test for how best to
        
//        print(location)
//        print((location?.coordinate.latitude)!)
//        print((location?.coordinate.longitude)!)
        
        //Broadcast position of bus
        //by using FireBase
        
        let info: String = "\(bus)\t1\t\(x)\t\(y)"
        
        appDelegate.databaseRef.child(school).child(bus).setValue(info)
        
    }
    
    @IBAction func startStopBusRide(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if !sender.isSelected {
            self.locationManager.stopUpdatingLocation()
            let info: String = "\(bus)\t0"
            appDelegate.databaseRef.child(school).child(bus).setValue(info)
        }
        else {
            self.locationManager.startUpdatingLocation()
        }
    }

}
