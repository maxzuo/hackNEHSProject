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
    
    class func retrieveBusinfo() {
        
    }
    
    class func retrieveSchoolNames() -> Array<String>? { // Remove optional once actually receiving data
        return nil
    }
    
    class func retrieveSchoolInfo() -> String? {
        let defaults = UserDefaults.standard
        if let selectedSchool = defaults.value(forKey: "School") as? NSString {
            // retrieve post with name selectedSchool
            // return info as string
        }
        
        return nil
        
    }
}
