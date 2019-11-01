//
//  CreateGameViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 9/20/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import Photos
import DownPickerSwift
import DateTimePicker

class CreateEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate,  UINavigationControllerDelegate, DateTimePickerDelegate {

    var pickerData: [String] = [String]() //count values for picker
    
    var player_Count : Int?
    var currentUser : Users?
    var sportPicker : DownPicker?
    var skillPicker : DownPicker?
    var imagePicked : UIImage? = nil
    var timeSelected : String?
    
    let photoPicker = UIImagePickerController()

    @IBOutlet weak var mainStackView: UIStackView!
  
    @IBOutlet weak var selectSport: UITextField!
    
    @IBOutlet weak var selectLevel: UITextField!
    
    @IBOutlet weak var playerCount: UIPickerView!
    
    @IBOutlet weak var addPhotoBttn: UIButton!
    
    @IBOutlet weak var dateTimeBtn: RoundButton!
    
    
    @IBAction func dateTimeBttn(_ sender: UIButton) {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 0)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker.darkColor = UIColor.darkGray
        picker.tintColor = #colorLiteral(red: 0.2143170787, green: 0.3068860071, blue: 0.5, alpha: 1)
        picker.highlightColor = #colorLiteral(red: 0.2143170787, green: 0.3068860071, blue: 0.5, alpha: 1)
        
        picker.frame = CGRect(x: 0, y: 100, width: picker.frame.size.width, height: picker.frame.size.height)
        picker.is12HourFormat = true
        picker.delegate = self
        picker.show()
        sender.isHighlighted = true
        sender.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
    }
    
    @IBAction func selectPicture(_ sender: UIButton) {
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
                                                self.photoPicker.modalPresentationStyle = .formSheet
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
                print("setting up the image")
                self.imagePicked = chosenImage
                
                let thumPic = chosenImage.resizeImageUsingVImage(size: CGSize(width: 200, height: 200))
                
                self.addPhotoBttn.setBackgroundImage(thumPic, for: .normal)
                self.addPhotoBttn.setTitle("", for: .normal)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
        setupFields()
        setTextfields()
        // Do any additional setup after loading the view.
    }
    
    func setTextfields(){
        selectLevel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        selectSport.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
  
    func setupFields(){
        self.playerCount.delegate = self
        self.playerCount.dataSource = self
        playerCount.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        // Input the data into the array
        for i in 1...30{
            pickerData.append(i.description)
        }
        setupSportlevelPicker()
        photoPicker.delegate = self
    }
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
       //title = picker.selectedDateString
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"

        picker.dateFormat = formatter.dateFormat
        timeSelected = picker.selectedDateString
        self.dateTimeBtn.setTitle(picker.selectedDateString, for: .normal)
    }
    func setupSportlevelPicker(){
        guard let currentUser = currentUser else { print("empty user error")
            return
        }
        sportPicker = DownPicker(with: selectSport, data: currentUser.sports)
        sportPicker?.arrowImage = UIImage(named: "icons8-sort_down.png")
        sportPicker?.placeholder = "Select Sport"
        
        skillPicker = DownPicker(with: selectLevel, data: ["beginner", "average", "expert"])
        skillPicker?.arrowImage = UIImage(named: "icons8-sort_down.png")
        skillPicker?.placeholder = "Skill Level"
        

    }
    
    
    func loadUser(){
        let defaults = UserDefaults.standard
        guard let userData = defaults.object(forKey: "currUser") as? Data else {
            return
        }
        // Use PropertyListDecoder to convert Data into Player
        guard let user = try? PropertyListDecoder().decode(Users.self, from: userData) else {
            return
        }
        self.currentUser = user
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int){
        let numValueSelected = Int (pickerData[row]) ?? 0
        //print(yearValueSelected)
        self.player_Count = numValueSelected
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        //let titleData = "data"
        let myTitle = NSAttributedString(string: pickerData[row] , attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)])
        
        return myTitle
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

