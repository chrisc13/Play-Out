//
//  NearbyViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 7/5/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import MapKit

class NearbyViewController: UIViewController {
    @IBOutlet weak var mainStackView: UIStackView!
    
   // var map :  MKMapView?
    
    @IBOutlet weak var m: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       // setBackground()
       // self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {
      
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        /*map?.delegate = nil
        map?.removeFromSuperview()
        map = nil*/
    }
    
    
}
