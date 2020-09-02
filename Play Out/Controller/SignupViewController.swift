//
//  SignupViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 5/22/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import Firebase
import Material

class SignupViewController: UIViewController, UITextFieldDelegate, ActivityIndicatorPresenter {
    
    var activityIndicator =  UIActivityIndicatorView()
   // @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var backView: UIView!
    
    var uid : String?
    
    
    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var passTF: UITextField!
    
    @IBOutlet weak var pass2TF: UITextField!
    
    
    @IBOutlet weak var regButton: UIButton!
    
    @IBAction func regBttn(_ sender: Any) {
        showActivityIndicator()
        
        var passMatch = true
        if passTF.text != nil && pass2TF != nil{
            if passTF.text! != pass2TF.text!{
                passMatch = false
                Alert.showBasicAlert(on: self, with: "Password Error", message: "Passwords do not match", actionName: "Okay")
                hideActivityIndicator()
            }
        }
       print(passMatch)
    
        
        
    if passMatch{
        print("TRY TO AUTH")
        Auth.auth().createUser(withEmail: (emailTF.text ?? ""), password: (pass2TF.text ?? "")) { (result, error) in
            if let _eror = error {
                self.hideActivityIndicator()
                Alert.showBasicAlert(on: self, with: _eror.localizedDescription, message: "", actionName: "Okay")
                //something bad happning
                print(_eror.localizedDescription )
               
                
            }else {
                //user registered successfully
       
                print("NEW USER IS MADE NOW")
                
                
                
                guard let id = Auth.auth().currentUser?.uid else{ return }
                
                print(id)
                self.uid = id
                
                self.hideActivityIndicator()
                //segue to next view with all this stuff as the user info since it is saved
                self.performSegue(withIdentifier: "proSet", sender: Any?.self)
                print("got here")
            }
        }
        
        
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "proSet"){
            let dest = segue.destination as! ProfileSetupViewController
            //print("Passed", uid)
            dest.uid = uid
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        self.hideKeyboardWhenTappedAround()
        makeButton()
        backView.layer.cornerRadius = 15
     
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("in here ")
        
        
        if textField.tag == 0 {
            textField.autocorrectionType = .no
        } else {
            textField.autocorrectionType = .no
        }
        return true
    }
    
    
    func makeButton(){

        regButton.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
       
    }
    fileprivate func setBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "b2.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
      
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTF {
            textField.resignFirstResponder()
            passTF.becomeFirstResponder()
        } else if textField == passTF{
            textField.resignFirstResponder()
            pass2TF.becomeFirstResponder()
        }else if textField == pass2TF{
            //textField.resignFirstResponder()
            //passTF.becomeFirstResponder()
          
            regButton.sendActions(for: UIControl.Event.touchUpInside) //to sim a bttn press

        }
        return true
    }

}

