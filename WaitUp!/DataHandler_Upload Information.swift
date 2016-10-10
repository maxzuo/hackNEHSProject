//
//  DataHandler.swift
//  WaitUp!
//
//  Created by Max Zuo on 10/8/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DataHandler {
    
    
    // ONLY USE BELOW FUNCTION AS TEST. NO LONGER A NECESSARY THING TO USE.
    /*class func updateSchoolStrings() {
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("School_Names").child("1").setValue("Lincoln-Sudbury Regional High School\tConcord Carlisle\tActon Boxborough High School")
        
        databaseRef.child("Lincoln-Sudbury Regional High School").child("1").setValue("B1")
        databaseRef.child("Concord Carlisle").child("1").setValue("")
        databaseRef.child("Acton Boxborough").child("1").setValue("")
        
    }
    
    class func updateBusPosition() {
        let bus = UserDefaults.standard.value(forKey: "Bus") as? NSString as! String
        let school = UserDefaults.standard.value(forKey: "School") as? NSString as! String
        
        let text = DataHandler.retrieveSchoolInfo()!
        var lines = text.components(separatedBy: "\n")
        
        var newInfo: String = ""
        
        for line in lines {
            if line.contains(bus) {
                newInfo += "\(bus)\t0.0\t0.0"
            }
            else {
                newInfo += line
            }
        }
        
        newInfo = String(newInfo.characters.dropLast())
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child(school).child("1").setValue(newInfo)
        
    }*/
    
}
