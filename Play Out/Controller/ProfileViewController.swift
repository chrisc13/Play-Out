//
//  ProfileViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 7/8/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import Material
import CircleMenu

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var bView: UIView!
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    let kCellHeight:CGFloat = 60.0
    var sampleTableView:UITableView!
    
    var profileName : String?
    var profileCity : String?
    var profileAge : Int?
    var profileGender : String?
    var sports = [String]()
    var levels = [String]()
    var showSave = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        loadUser()
        createView()
        
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
        
        guard let data  = defaults.object(forKey: "currUserImage") else{return}
        
        guard let i = UIImage(data: data as! Data) else {return}
        guard let resized = i.resizeImageUsingVImage(size: CGSize(width: 235, height: 250)) else {return}
        
        //profilePictureView.image = UIImage(data: data as! Data)
        
       // let ag = "| "
        
        profileName = user.name
        profileCity = user.city
        profileAge = user.age
        profileGender = user.gender
        //profileImage?.image = UIImage(data: data as! Data)
       
        profileImage.image = resized
        //235x418 pixels
        
        
        
        
        sports = user.sports
        levels = user.levels
        
        print("user name is \(user.name)")
        print(user.city)
        print(user.age)
        
    }
 
    
    
    func createView(){
        let defView = UIView()
        defView.backgroundColor = .blue
       // defView.borderColor = 5
        
        
        profileImage.dropShadow(color: .black, opacity: 1, offSet: CGSize(width: -1, height: -2), radius: 3, scale: true)
        
        profileImage.layer.cornerRadius = 15
        
        bView.dropShadow(color: .black, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)

        bView.layer.cornerRadius = 15
     

        bView.dropShadow(color: .black, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        let profileInfo = UIStackView() //holds the name and city
        profileInfo.axis = .horizontal
        profileInfo.alignment = .fill
        profileInfo.distribution = .fillEqually
        
         
        let profileInfo2 = UIStackView()    //holds the age and gender
        profileInfo2.axis = .horizontal
        profileInfo2.alignment = .fill
        profileInfo2.distribution = .fillEqually
        
        
        
        let genderBttn = createButton(title: profileGender ?? " ", fontSize: 16, darkText: false)
        genderBttn.addTarget(self, action: #selector(namePressed(sender:)), for: .touchUpInside)

        let nameBttn = createButton(title: profileName ?? "", fontSize: 20, darkText: true)
        nameBttn.addTarget(self, action: #selector(namePressed(sender:)), for: .touchUpInside)
        
        let cityBttn = createButton(title: profileCity ?? " ", fontSize: 16, darkText: false)
        cityBttn.addTarget(self, action: #selector(namePressed(sender:)), for: .touchUpInside)
        
        let ageBttn = createButton(title: profileAge?.description ?? " ", fontSize: 16, darkText: false)
        ageBttn.addTarget(self, action: #selector(namePressed(sender:)), for: .touchUpInside)
     
        
        let sportBttn = createButton(title: "Weightlifting" ?? " ", fontSize: 16, darkText: false)
      sportBttn.addTarget(self, action: #selector(namePressed(sender:)), for: .touchUpInside)
        

        profileInfo.addArrangedSubview(cityBttn)
        profileInfo.addArrangedSubview(nameBttn)
        profileInfo.addArrangedSubview(sportBttn)
        
 
    
        
        mainStackView.addArrangedSubview(profileInfo)//has the username
        //mainStackView.addArrangedSubview(profileInfo2)
       
        
        let sportsStack = UIStackView() //holds the name and city
        sportsStack.axis = .horizontal
        sportsStack.alignment = .fill
        sportsStack.distribution = .fillEqually
        

        
        
        var index = 0
            for i in sports{
                index += 1
                
              
                let b = createButton(title: i, fontSize: 16, darkText: false)
                
          
                
                
                sportsStack.addArrangedSubview(b)
                
                /*if index > 3{
                    mainStackView.addArrangedSubview(sportsStack)
                    let secStack = UIStackView() //holds the name and city
                    secStack.axis = .horizontal
                    secStack.alignment = .fill
                    secStack.distribution = .fillEqually
                    for x in 3..<sports.count{
                        let c = UIButton()
                        c.setTitle(sports[x], for: .normal)
                        c.setTitleColor(.gray, for: .normal)
                        c.fontSize = 16
                        secStack.addArrangedSubview(c)
                        
                    }
                    mainStackView.addArrangedSubview(secStack)
                    
                }else{
                    
                }*/
                
                
        }
        
        
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        
        self.bView.addSubview(mainStackView)
    }
  
    
    
    func createButton(title: String, fontSize: CGFloat, darkText: Bool)-> UIButton{
        let b = UIButton()
        b.setTitle(title, for:.normal)
        b.fontSize = fontSize
        b.showsTouchWhenHighlighted = true
        b.titleLabel?.minimumScaleFactor = 0.5
        b.titleLabel?.numberOfLines = 1
        b.titleLabel?.adjustsFontSizeToFitWidth = true
        if darkText {
            b.setTitleColor(.black, for: .normal)
        }else{
            b.setTitleColor(.gray, for: .normal)

        }
        return b
    }
    
    
    func displaySave(){
     
        if self.showSave{
        let a = UILabel()
        a.text = ""
        a.textAlignment = .center
        let b = UILabel()
        b.text = ""
        b.textAlignment = .center
        
        
        let saveStack = UIStackView() //holds the name and city
        saveStack.axis = .horizontal
        saveStack.alignment = .fill
        saveStack.distribution = .fillEqually
        
        let saveBttn = UIButton()
    
        saveBttn.setTitle("Tap to begin editing", for: .normal)
        let font = UIFont(name: "Helvetica", size:16)
        saveBttn.titleLabel?.font = font
        saveBttn.backgroundColor = #colorLiteral(red: 0.1957998574, green: 0.2037419081, blue: 0.2162097394, alpha: 1)
        saveBttn.setTitleColor(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), for: .normal)
        saveBttn.layer.cornerRadius = 15
    
        saveStack.addArrangedSubview(a)
        saveStack.addArrangedSubview(saveBttn)
        saveStack.addArrangedSubview(b)
        saveBttn.addTarget(self, action: #selector(savePressed(_:)), for: .touchUpInside)
        
            self.showSave = false
          mainStackView.addArrangedSubview(saveBttn)
        //mainStackView.addArrangedSubview(saveStack)
        }
    }

    
    @objc func namePressed(sender : UIButton!){
        // if (profileName)
      //  Alert.showBasicAlert(on: self, with: "Editing", message: "Enter new name", actionName: "Ok")
        
        //Alert.showTextFieldAlert(on: self, with: "Test", message: "123", actionname: "Okay", placehold: "Whteve")
        let a = UIAlertController(title: "TEST", message: "test", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        a.addAction(ok)
        a.setBackgroundColor(color: #colorLiteral(red: 0.1488672197, green: 0.1528193057, blue: 0.1611176431, alpha: 1))
        
        self.present(a, animated: true)
        
        
        displaySave()
    }
    
    
    
    @objc func savePressed(_: UIButton!){
       // if (profileName)
        
        
        
        print("saved")
        
    }
    
    
    
    func makeRounded(profilePic: UIImageView) {
        
        //profilePic.layer.borderWidth = 1
        profilePic.layer.masksToBounds = false
        //profilePic.layer.borderColor = UIColor.black.cgColor
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


/*
    let dropper = Dropper(width: 75, height: 200)
    @IBOutlet var dropdownButton: UIButton!
    
    @IBAction func DropdownAction() {
        if dropper.status == .Hidden {
            dropper.items = ["Item 1", "Item 2", "Item 3", "Item 4"] // Item displayed
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: dropdownButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
*/
extension UIView {

func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius
    
    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
}
}
/*extension ViewController: DropperDelegate {
    func DropperSelectedRow(path: NSIndexPath, contents: String) {
        /* Do something */
    }
}*/
extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
}
