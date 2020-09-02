//
//  Alert.swift
//  Play Out
//
//  Created by Chris Carbajal on 5/23/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import Foundation
import UIKit

class Alert : NSObject{
    
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String , actionName: String) {
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let delete = UIAlertAction(title: actionName, style: .default, handler: { action in
          
        })
        
        
        let ok = UIAlertAction(title: actionName, style: .default, handler: nil)
        
        if actionName == "Delete All"{ //this will change ok text to delete all if that is specified
            alert.addAction(delete)
        }else{
            alert.addAction(ok)
        }
        
        
       // alert.addAction(cancel)
        
        vc.present(alert, animated: true)
    }
    static func showTextFieldAlert(on vc: UIViewController, with title : String, message: String, actionname: String, placehold : String) -> String{
        var other = ""
        
        let addAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //addAlert.addAction(UIAlertAction(title: actionname, style: .default, handler: nil))
        
        addAlert.addTextField(configurationHandler: { textField in
            textField.keyboardType = .default
            textField.placeholder = placehold
            
        })
        
        addAlert.addAction(UIAlertAction(title: "Enter", style: .default, handler: { [weak addAlert] (_) in
            let textField = addAlert!.textFields![0] // Force unwrapping because we know it exists.
            //print("Text field: \(textField.text)")
            other = textField.text ?? "Other"
        }))
        
        
        
        
        
        vc.present(addAlert, animated: true)
        
   
        
        return other
    }
    
    
    
    
}

