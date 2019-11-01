//
//  HomeViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 7/7/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var testPic: UIImage? = nil
    
    var userID : String?
    
    
   
    
    @IBOutlet weak var profilePic: UIImageView!
    
    
    @IBAction func profBttn(_ sender: Any) {
      
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
       /* print("calllleddd?!!?!")
            let dest = segue.destination as! ProfilePictureViewController
            //dest.testPic = profilePic.image
        print(testPic?.description)
            dest.profPic = testPic*/
        
    
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print("again")
        profilePic.image = testPic?.resizeImageUsingVImage(size: CGSize(width: 100, height: 100))
        
        profilePic.contentMode = .scaleAspectFit
        makeRounded()
        setBackground()
        
        //maybe activate this if it fails again
        /*
        getUserData( completion: { result in
            switch result {
            case .success(let granted) :
                if granted{
                   
                    
                }else{
                    print("erro retrieving user photo")
                }
            case .failure(let error): print(error)
                
            }
            
            
        })*/
            
            
        print("In Home===-!")
        
    }
    enum UpResult{
        case success(Bool), failure(Error)
    }
    
    
    func getUserData(completion: @escaping (UpResult) -> () ){
        if Auth.auth().currentUser != nil{
            guard let uid  = Auth.auth().currentUser?.uid else {return}
            
            print(uid)
            FirestoreReferenceManager.root
            .document(uid)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                   // let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    
                    guard let data = document.data() else {return}
                    
                
                    if let user = Users(data: data) {
                        print("did this thing work??->", user.age)
                        
                        print("did this thing work??->", user.name)
                        
                        let defaults = UserDefaults.standard
                        
                        // Use PropertyListEncoder to convert Player into Data / NSData
                        defaults.set(try? PropertyListEncoder().encode(user), forKey: "currUser")
                        
                        
                    }else{
                        print("not allowed")
                    }
                    
                    
                    
                    //print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
            }
            
            
        }else{
            
        }
    
        
    }
    
    func makeRounded() {
        
        profilePic.layer.borderWidth = 1
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor.black.cgColor
        profilePic.layer.cornerRadius = profilePic.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        profilePic.clipsToBounds = true
    }
    fileprivate func setBackground() {
        //set app backgrouund image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "b2d.png")
        
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
   
    
}
