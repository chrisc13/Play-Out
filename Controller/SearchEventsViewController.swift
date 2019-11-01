//
//  SearchEventsViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 9/21/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SearchEventsViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func removeMapMemory() {
        //deallocate memory used
        map.mapType = MKMapType.satellite
        map.delegate = nil
        map.removeFromSuperview()
        map = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeMapMemory()
    }
    

}
