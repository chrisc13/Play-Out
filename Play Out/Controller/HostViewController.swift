//
//  HostViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 8/27/20.
//  Copyright © 2020 Chris Carbajal. All rights reserved.
//

import UIKit
import Firebase

class HostViewController: UIViewController {

    
    @IBOutlet weak var sportTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var peopleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    @IBOutlet weak var formContainer: UIView!
    
    
    override func viewDidLoad() {
        setFormUI()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickCreateEvent(_ sender: UIButton) {
        
        
        createEvent()
        
        
        
    }
    
    func setFormUI(){
        formContainer.layer.shadowColor = UIColor.black.cgColor
        formContainer.layer.shadowOpacity = 1
        formContainer.layer.shadowOffset = .zero
        formContainer.layer.shadowRadius = 10
        formContainer.layer.cornerRadius = 5
    }
    
    func createEvent(){
        // Add a new document with a generated id.
       // let ref: DocumentReference? = nil
        
        FirestoreReferenceManager.eventsCollection.addDocument(data: [
            "description": "my description",
            "location": locationTextField.text,
            "peopleNeeded": Int(peopleTextField.text ?? "")  ,
            "sport": sportTextField.text,
            "time": timeTextField.text
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: ")
            }
        }
        
        
    }
    
    
    enum DBResult {
        case success(Bool), failure(Error)
    }
    
    func uploadToDB(completion: @escaping (DBResult) ->() ){
//        guard let uid  = uid else {return}
//        guard let name  = name else {return}
//        guard let city  = city else {return}
//        guard let age  = age else {return}
//        guard let gender  = gender else {return}
//        guard let downloadURL = downloadURL else {return}
//
//        let sportsArray = Array(levelPickmap.keys)
//        let levelArray = Array(levelPickmap.values)
//
//
//        let dict: [String:Any] = ["name": name, "city": city, "age": age,"gender": gender
//            , "sports" : sportsArray, "levels" : levelArray, "pictureURL": downloadURL]
//
//        FirestoreReferenceManager.root
//            .document(uid)
//            .setData(dict) { (err) in
//                if let err = err {
//                    print(err.localizedDescription)
//                    completion(.failure(err))
//                }else{
//                    let defaults = UserDefaults.standard
//                    if let user = Users(data: dict){
//                    defaults.set(try? PropertyListEncoder().encode(user), forKey: "currUser")
//                    }else{
//                        print("error making user object")
//                    }
//
//
//
//
//
//
//                    print("ADDED USER SUCCESSFULLY!:)")
//                    completion(.success(true))
//
//                }
//        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
