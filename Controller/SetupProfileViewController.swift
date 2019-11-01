//
//  ProfileSetupViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 5/28/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import Photos
import Accelerate


class SetupProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    var pickerData: [String] = [String]() //age values for picker
    
    var age : Int?
    
    var uid : String?
    
    var malePick = false
    var femalePick = false
    
    var imagePicked : UIImage? = nil
    
    let photoPicker = UIImagePickerController()
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var cityTF: UITextField!
    
    
    @IBOutlet weak var maleBtn: UIButton!
    
    
    @IBOutlet weak var femaleBtn: UIButton!
    
    
    @IBAction func femaleBttn(_ sender: Any) {
        malePick = false
        femalePick = true
        if femalePick{
            femaleBtn.backgroundColor = #colorLiteral(red: 0.330473721, green: 0.4147269726, blue: 0.4814503193, alpha: 1)
            maleBtn.backgroundColor = .clear
        }
    }
    
    
    @IBAction func maleBttn(_ sender: Any) {
        femalePick = false
        malePick = true
        if malePick{
            maleBtn.backgroundColor = #colorLiteral(red: 0.330473721, green: 0.4147269726, blue: 0.4814503193, alpha: 1)
            femaleBtn.backgroundColor = .clear
        }
    }
    
    
    @IBOutlet weak var addPhotoBtn: circleButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setBackground()
        photoPicker.delegate = self
        
        usernameTF.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        cityTF.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        self.picker.delegate = self
        self.picker.dataSource = self
        picker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        // Input the data into the array
        
        for i in 13...65{
            pickerData.append(i.description)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let alertController = UIAlertController(title: "Take or choose", message: nil
            , preferredStyle: .alert)
        
        let serachAction = UIAlertAction(title: "Library", style: .default) { (action) in
            // load image
            self.photoPicker.sourceType = .photoLibrary
            // display image selection view
           self.present(self.photoPicker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .default) { (action) in
                                            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                                //self.photoPicker.delegate = self
                                                self.photoPicker.allowsEditing = false
                                                self.photoPicker.sourceType = UIImagePickerController.SourceType.camera
                                                self.photoPicker.cameraCaptureMode = .photo
                                                self.photoPicker.modalPresentationStyle = .fullScreen
                                                self.present(self.photoPicker,animated: true,completion: nil)
                                            } else {
                                                print("No camera")
                                            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addAction(cameraAction)
        alertController.addAction(serachAction)
        alertController.addAction(cancelAction)

        alertController.view.layoutIfNeeded()
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            picker.dismiss(animated: true, completion: {
                //let pic = self.resizeImage(image: chosenImage, newWidth: 110)
               
            
               // let pic = chosenImage.resizeImageUsingVImage(size: CGSize(width: 200, height: 200))
                self.imagePicked = chosenImage
                
                let thumPic = chosenImage.resizeImageUsingVImage(size: CGSize(width: 100, height: 100))
                
                
                self.addPhotoBtn.setBackgroundImage(thumPic, for: .normal)
                self.addPhotoBtn.setTitle("", for: .normal)
                
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSelect"){
            let dest = segue.destination as! SportsSelectViewController
            dest.uid = uid
            dest.profImage = imagePicked
            dest.name = usernameTF.text
            dest.city = cityTF.text
            dest.age = age
            dest.gender = getGender()
        }
    }

    func getGender()->String{
        if malePick{
            return "Male"
        }else {
            return "Female"
        }
        
    }
  
    @IBOutlet weak var bView: UIView!
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBAction func doneBttn(_ sender: Any) {
       // if age
        if imagePicked == nil{
           // Alert.showBasicAlert(on: self, with: "Incomplete Field", message: "Do you want to set profile picture", actionName: "Ok")

            let alert = UIAlertController(title: "Incomplete Field", message: "Choose profile picture", preferredStyle: .alert)
            let defaultIm = UIAlertAction(title: "Use a Default", style: .default, handler: {  action in
                print("add default here")
                
                let defPic = UIImage(named: "icons8-user-100")
                
                
                //let pic = defPic?.resizeImageUsingVImage(size: CGSize(width: 100, height: 100))
                self.imagePicked = defPic
                
                  // self.addPhotoBtn.titleLabel?.text = "hey"
                self.addPhotoBtn.setTitle("", for: .normal)
                
                
                self.addPhotoBtn.setBackgroundImage(defPic, for: .normal)
             
             
                })
            
            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(defaultIm)
            alert.addAction(ok)
            self.present(alert, animated: true)
            
        }
        
        else if usernameTF.text == ""{
            Alert.showBasicAlert(on: self, with: "Incomplete Field", message: "Please input name", actionName: "Ok")
        }else if cityTF.text == ""{
            Alert.showBasicAlert(on: self, with: "Incomplete Field", message: "Please input city", actionName: "Ok")
        }else if age == 1{
            Alert.showBasicAlert(on: self, with: "Incomplete Field", message: "Please input age", actionName: "Ok")
        }else if (!femalePick && !malePick){
            Alert.showBasicAlert(on: self, with: "Incomplete Field", message: "Please input gender", actionName: "Ok")
        }else{
            self.performSegue(withIdentifier: "toSelect", sender: Any?.self)
        }
    
        
    }
    

    fileprivate func setBackground() {
        //set app backgrouund image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "b2.png")
        
        //applyMotionEffect(toView: backgroundImage, magnitude: 0)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        bView.layer.cornerRadius = 45
        bView.layer.shadowColor = #colorLiteral(red: 0.1688885884, green: 0.2130006477, blue: 0.2408076697, alpha: 1)
        bView.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        bView.layer.shadowOpacity = 0.5
        bView.layer.shadowRadius = 1.0
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int){
        
        let yearValueSelected = Int (pickerData[row]) ?? 0
        print(yearValueSelected)
        self.age = yearValueSelected
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
          return 30
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
    }

     //The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTF{
            print("USERNAME in control")
            textField.resignFirstResponder()
            cityTF.becomeFirstResponder()
        } else if textField == cityTF{
            print("CITY in control")

            textField.resignFirstResponder()
        }
        return true
    }
    
    
}





