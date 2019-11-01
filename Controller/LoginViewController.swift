//
//  LoginViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 5/21/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class LoginViewController: UIViewController, UITextFieldDelegate,  ActivityIndicatorPresenter, NVActivityIndicatorViewable {
   
    var activityIndicator = UIActivityIndicatorView()

    var profImage : UIImage? = nil
    var uid : String?
    var name : String?
    @IBOutlet weak var bView: UIView!
    
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passTF: UITextField!
    
    @IBAction func forgotButton(_ sender: Any) {
        print("forgot clicked")
    }
    

    override func viewDidLoad() {
        makeButton()
        super.viewDidLoad()
        setBackground()
        bView.layer.cornerRadius = 15
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func enterBtn(_ sender: Any) {
        print("Fetching user details")
        //showActivityIndicator()
        let indicatorType = NVActivityIndicatorType.orbit
        let activityIndicatorView = NVActivityIndicatorView(frame: self.view.frame,
                                                            type: indicatorType)
        view.addSubview(activityIndicatorView)
        
        startAnimating()
        signIn()
    }
    
    func signIn(){
        Auth.auth().signIn(withEmail: emailTF.text ?? "" , password: passTF.text ?? "", completion: { (user, error) in
            if let error = error {
                self.stopAnimating()
                //self.hideActivityIndicator()
                Alert.showBasicAlert(on: self, with: error.localizedDescription, message: "", actionName: "Okay")
            }else if error == nil{
                
                
                guard let uid = Auth.auth().currentUser?.uid else{return}
                
                self.getProfilePicture(uid: uid, completion: { result in
                    switch result {
                    case .success(let granted) :
                            if granted{
                                print("granted profile picutr")
                                
                                self.getUserData( completion: { result in
                                    switch result {
                                    case .success(let granted) :
                                        if granted{
                                            self.stopAnimating()
                                            //self.hideActivityIndicator()
                                            self.performSegue(withIdentifier: "toHome", sender: self)
                                            
                                        }else{
                                            print("erro retrieving user photo")
                                        }
                                    case .failure(let error): print(error)
                                        
                                    }
                                    
                                })
                                
                                
                                
                            }else{
                                print("erro retrieving user photo")
                        }
                    case .failure(let error): print(error)
                        

                    }
                    
                    
                })
                
            }
        })
    }
    
    
    func getUserData(completion: @escaping (UserResult) -> () ){
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
                            
                              completion(.success(true))
                            
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
    
    
    
    enum UpResult {
        case success(Bool), failure(Error)
    }
    
    enum UserResult {
        case success(Bool), failure(Error)
    }
    

    func getProfilePicture(uid:String, completion: @escaping(UpResult) ->() ){
        
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        let imgRef = storageRef.child(uid)
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imgRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                completion(.failure(error))
            } else {
                // Data for "images/island.jpg" is returned
                guard let img = UIImage(data: data!) else{return}
                
                guard let data = img.jpegData(compressionQuality: 1.0) else {return}
                UserDefaults.standard.set(data, forKey: "currUserImage")
                
                
                
                self.profImage = img
                completion(.success(true))
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let barVC = segue.destination as? UITabBarController {
            barVC.viewControllers?.forEach {
                if let vc = $0 as? HomeViewController {
                    vc.testPic = profImage
                }
            }
        }
    }

    func makeButton(){
    
        enterButton.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    fileprivate func setBackground() {
        //set app backgrouund image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "b2.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        //applyMotionEffect(toView: backgroundImage, magnitude: 0.0)
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    func applyMotionEffect(toView view:UIView, magnitude: Float){
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -70
        xMotion.maximumRelativeValue = 70
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = 0
        yMotion.maximumRelativeValue = 1
        let motionGroup = UIMotionEffectGroup()
        motionGroup.motionEffects = [xMotion, yMotion]
        view.addMotionEffect(motionGroup)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTF {
            textField.resignFirstResponder()
            passTF.becomeFirstResponder()
        } else if textField == passTF{
            textField.resignFirstResponder()
            //passTF.becomeFirstResponder()
        }
        return true
    }
    
}
