//
//  DataHandler_RetrieveInformation.swift
//  WaitUp!
//
//  Created by David Cincotta on 10/8/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

extension DataHandler {
    
    class func retrieveBusinfo() -> [Float]? {
        
        let defaults = UserDefaults.standard
        let bus = defaults.value(forKey: "Bus") as? NSString as! String
        
        let text = DataHandler.retrieveSchoolInfo()?.components(separatedBy: "\n")
        
        for line in text! {
            if line.contains(bus) {
                let information = line.components(separatedBy: "\t")
                return [(NumberFormatter().number(from: information[1])?.floatValue)!, (NumberFormatter().number(from: information[2])?.floatValue)!]
            }
        }
        
        return nil
    }
    
    class func retrieveSchoolNames() -> Array<String> { // Remove optional once actually receiving data

        var schoolNames: Array<String> = []
        let database = FIRDatabase.database().reference()
        
        database.child("School_Names").queryOrderedByKey().observe(.childChanged, with: {
            snapshot in
            schoolNames = (snapshot.value! as! String).components(separatedBy: "\t")
            
        })
        
        return schoolNames
        
    }
    
    class func retrieveSchoolInfo() -> String? {
        
        var schoolInfo: String = ""
        
        let defaults = UserDefaults.standard
        
        if let selectedSchool = defaults.value(forKey: "School") as? NSString {
            // retrieve post with name selectedSchool
            // return info as string
            let database = FIRDatabase.database().reference()
            database.child(selectedSchool as! String).queryOrderedByKey().observe(.childChanged, with: {
                snapshot in
                schoolInfo = snapshot.value! as! String
                
            })
            
            return schoolInfo
            
        }
        return nil
    }
    
}
