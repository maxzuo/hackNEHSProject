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
    
    var annotation: MKPointAnnotation!
    var userLocation: CLLocation?
    
    var busOnMap: Bool = false
    var busWithinRegion: Bool = false
    
    //var annotation: MKAnnotation

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userLocation = nil
        
        self.map.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
                
        appDelegate.databaseRef.child(defaults.value(forKey: "School") as? NSString as! String).child(defaults.value(forKey: "Bus") as? NSString as! String).observe(.value) { (snap: FIRDataSnapshot) in
//            print(self.map.annotations)
            
            var busInfo: Array<String>
            busInfo = ((snap.value! as! NSString) as String).components(separatedBy: "\t")
            busInfo.removeFirst()
//            print("THIS IS BUSINFO: \(busInfo)")
            
            if busInfo[0] == "1" {
                let x = busInfo[1]
                let y = busInfo[2]
//                print("in loop busInfo == 1")
//                
//                print((NumberFormatter().number(from: x)?.doubleValue)!)
                
                let location = CLLocationCoordinate2D(latitude: (NumberFormatter().number(from: x)?.doubleValue)!, longitude: (NumberFormatter().number(from: y)?.doubleValue)!)
                
                self.annotation = MKPointAnnotation()
                self.annotation.coordinate = location
                self.annotation.title = "Bus"
                self.annotation.subtitle = "Bus"
                
                if !self.busOnMap {
                    self.map.addAnnotation(self.annotation)
                    self.busOnMap = true
                } else {
//                    self.map.removeAnnotations([self.map.annotations.last!])
                    self.map.removeAnnotations(self.map.annotations)
                    self.map.addAnnotation(self.annotation)
                }
                
                let busPosition = CLLocation(latitude: self.annotation.coordinate.latitude, longitude: self.annotation.coordinate.longitude)
                
                if self.userLocation != nil {
                    let distance: Double = self.userLocation!.distance(from: busPosition)

                    if distance <= 600000000 {
                        if UIApplication.shared.applicationState == .inactive || UIApplication.shared.applicationState == .background && self.busWithinRegion {
                            self.busWithinRegion = true
                            print(distance)
                            let notification = UILocalNotification()
                            notification.alertAction = "Ok"
                            notification.alertBody = "The bus is now within \(distance) meters of you."
                            notification.fireDate = NSDate(timeIntervalSinceNow: 10) as Date
                            notification.soundName = UILocalNotificationDefaultSoundName
                            UIApplication.shared.scheduleLocalNotification(notification)
//                          UIApplication.shared.local
                        }
                        else {
                            let alertController = UIAlertController(title: "Oops!", message: "You didn't give your assignment a name!", preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    
                }
                else {
                    self.busWithinRegion = false
                }

                
            } else if busInfo[0] == "0" {
                if self.map.annotations.count > 1 {
                    self.busOnMap = false
                    self.map.removeAnnotations(self.map.annotations)
                }
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
        userLocation = locations.last
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
