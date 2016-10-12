//
//  MapViewController.swift
//  WaitUp!
//
//  Created by Max Zuo on 10/8/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase
import CoreLocation

class StudentMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    
    var setUpLocation = true
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let defaults = UserDefaults.standard
    
    //var annotation: MKAnnotation

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
        
        appDelegate.databaseRef.child(defaults.value(forKey: "School") as? NSString as! String).child(defaults.value(forKey: "Bus") as? NSString as! String).observe(.value) { (snap: FIRDataSnapshot) in
            print(self.map.annotations)
            
            var busInfo: Array<String>
            busInfo = ((snap.value! as! NSString) as String).components(separatedBy: "\t")
            busInfo.removeFirst()
            print("THIS IS BUSINFO: \(busInfo)")
            
            if busInfo[0] == "1" {
                let x = busInfo[1]
                let y = busInfo[2]
                
                print((NumberFormatter().number(from: x)?.doubleValue)!)
                
                let location = CLLocationCoordinate2D(latitude: (NumberFormatter().number(from: x)?.doubleValue)!, longitude: (NumberFormatter().number(from: y)?.doubleValue)!)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = "Bus"
                annotation.subtitle = "Bus"
                
                self.map.addAnnotation(annotation)
                
            } else {
                
            }
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        
        if setUpLocation {
            self.map.setRegion(region, animated: true)
            setUpLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location ERROR: " + error.localizedDescription)
    }

}
