//
//  FindLocationViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 9/30/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import MapKit


class FindLocationViewController: UIViewController {

    
    @IBOutlet weak var enteredLocation: UITextField!
    
    
    
    @IBOutlet weak var map: MKMapView!
    
    
    
    @IBAction func sendLocation(_ sender: Any) {
        
        //geocode()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
//    func geocode() {
//
//
//        guard let inputaddress = enteredLocation.text else{return}
//
//
//    CLGeocoder().geocodeAddressString(inputaddress, completionHandler:
//    {(placemarks, error) in
//
//    if error != nil {
//    print("Geocode failed: \(error!.localizedDescription)")
//    } else if placemarks?.count > 0 {
//    let placemark = placemarks![0]
//    let location = placemark.location
//
//
//
//    let lat = location?.coordinate.latitude
//    let lon = location?.coordinate.longitude
//
//
//    let span = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
//        let region = MKCoordinateRegion(center: placemark.location?.coordinate, span: span)
//    self.map.setRegion(region, animated: true)
//
//    let ani = MKPointAnnotation()
//
//    ani.coordinate = placemark.location!.coordinate
//    print(placemark.location!.coordinate)
//    ani.title = placemark.locality
//    ani.subtitle = placemark.subLocality
//
//
//
//
//
//    getJson(lat: lat!, long: lon!, completion: {response, r, s in
//    for i in response{
//
//    let new = MKPointAnnotation()
//    new.coordinate = CLLocationCoordinate2D(latitude: i.key, longitude: i.value)
//
//
//    for k in r{
//    new.title = k.key
//    new.subtitle = k.value.description
//    self.map.addAnnotation(new)
//
//    for a in s{
//
//    DispatchQueue.main.async {
//    self.test = a.key
//
//
//    self.textArea.backgroundColor =  UIColor .lightGray
//    self.textArea2.backgroundColor = UIColor .lightGray
//
//    if (self.count<response.count){
//    self.textArea.insertText("    Earthquake Id: ")
//
//    self.textArea.insertText(a.key+"\n")
//
//    self.textArea2.insertText("  Magnitude: ")
//    self.textArea2.insertText(a.value.description+"\n")}
//    self.count = self.count+1
//    }
//    }
//    }
//
//
//    }
//
//
//
//
//    }
//    )
//        }
//        })
//    }
}
