//
//  SportLevelViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 5/24/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//


import UIKit
import Firebase
import NVActivityIndicatorView

class SportLevelViewController: UIViewController, ActivityIndicatorPresenter, NVActivityIndicatorViewable {
    
    var activityIndicator = UIActivityIndicatorView()

    var sports = [String]() //sports selected passed in from previous controller
    
    var buttonNames =  [String]() //button names in array
    var buttons = [UIButton]()
    var currentIndex = 0
    var countSelected = 0
    
    var uid : String?
    var profImage : UIImage? = nil
    var name : String?
    var city : String?
    var age : Int?
    var gender : String?
    //var : String?
    var downloadURL : String?
    
    
    var levelPickmap = [String:String]()//where string(sport) is key, and Bool(value) indicates which level marked
    
  
    @IBOutlet weak var levelsStack: UIStackView!
    
    @IBAction func doneBttn(_ sender: Any) {
        for i in buttons{
            if i.backgroundColor == #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1){
                print("increasing")
                self.countSelected+=1
            }
        }
        
        print("CHECK THE NUMBERS HERE-->")
        print(levelPickmap.count)
        print(countSelected)
        print(sports.count)

        
        
        if ( (levelPickmap.count < 1)  || (countSelected != sports.count) ){
            print("not to create ")

            Alert.showBasicAlert(on: self, with: "Incomplete", message: "Missing input", actionName: "Ok")
            countSelected = 0
        }else{
            let indicatorType = NVActivityIndicatorType.orbit
            let activityIndicatorView = NVActivityIndicatorView(frame: self.view.frame,
                                                                type: indicatorType)
            view.addSubview(activityIndicatorView)
            
            startAnimating()
            
            
            
            //showActivityIndicator()
            
            guard let uid  = uid else {return}
            guard let profImage = profImage else{return}
            print("got to create ")
            
            
            uploadPicture(img: profImage, uid: uid) { result  in
                switch result {
                case .success(let granted) :  //uploading to storage
                    if granted {
                        print("uploaded image to Storage")

                        self.uploadToDB(completion: { result  in
                            switch result {
                            case .success(let granted) :  //uploading to database
                                if granted {
                                    print("uploaded all the data to DB")
                                    //self.hideActivityIndicator()
                                    
                                    self.stopAnimating()
                                    self.performSegue(withIdentifier: "toHome", sender: Any?.self)
                                    // self.uploadToDB(
                                } else {
                                    print("access is denied")
                                }
                            case .failure(let error): print(error)
                            }
                        })
                        
                    } else {
                        print("access is denied")
                    }
                case .failure(let error): print(error)
                }
            }
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let barVC = segue.destination as? UITabBarController {
            barVC.viewControllers?.forEach {
                if let vc = $0 as? HomeViewController {
                    guard let data = profImage?.jpegData(compressionQuality: 1.0) else {return}
                    UserDefaults.standard.set(data, forKey: "currUserImage")
                    vc.testPic = profImage
                    
                }
            }
        }
    }
    
    
    func uploadToDB(completion: @escaping (DBResult) ->() ){
        guard let uid  = uid else {return}
        guard let name  = name else {return}
        guard let city  = city else {return}
        guard let age  = age else {return}
        guard let gender  = gender else {return}
        guard let downloadURL = downloadURL else {return}
        
        let sportsArray = Array(levelPickmap.keys)
        let levelArray = Array(levelPickmap.values)
        
        
        let dict: [String:Any] = ["name": name, "city": city, "age": age,"gender": gender
            , "sports" : sportsArray, "levels" : levelArray, "pictureURL": downloadURL]
        
        FirestoreReferenceManager.root
            .document(uid)
            .setData(dict) { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    completion(.failure(err))
                }else{
                    let defaults = UserDefaults.standard
                    if let user = Users(data: dict){
                    defaults.set(try? PropertyListEncoder().encode(user), forKey: "currUser")
                    }else{
                        print("error making user object")
                    }
                    
                    
                    
                    
                    
                    
                    print("ADDED USER SUCCESSFULLY!:)")
                    completion(.success(true))
                    
                }
        }
    }
    
    enum UpResult {
        case success(Bool), failure(Error)
    }
    enum DBResult {
        case success(Bool), failure(Error)
    }
    
    
    func uploadPicture(img: UIImage, uid: String, completion: @escaping (UpResult) ->()  ){

        guard let resized = img.resizeImageUsingVImage(size: CGSize(width: 235, height: 350)) else {return}
        
        guard let data = resized.jpegData(compressionQuality: 1.0) else {return}

        let storage = Storage.storage()
        let storageRef = storage.reference()
        
    // Create a reference to the file you want to upload
        let imgRef = storageRef.child(uid)
    
    // Upload the file to the path "images/rivers.jpg"
        let _ = imgRef.putData(data, metadata: nil) { (metadata, error) in
        guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
        }
        metadata.contentType = "image/jpg"
        // Metadata contains file metadata such as size, content-type.
        let _ = metadata.size
        // You can also access to download URL after upload.
        imgRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
                  completion(.failure(error!))
                return
            }
            self.downloadURL = downloadURL.absoluteString
            completion(.success(true))
            
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        //self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        createMyView()
        
        print("IN SKILL SELECTION::")
        for i in sports{
            print(i)
        }
        
    }

    
    func createMyView(){ //create level buttons dynamically
        var index = 0
        var i = 0
        for _ in sports{
            let mystack = UIStackView()
            mystack.axis = .horizontal
            mystack.distribution = .fillEqually
            mystack.alignment = .fill
            
            let mystackTest = UIStackView()
            mystackTest.axis = .vertical
            mystackTest.distribution = .fillEqually
            mystackTest.alignment = .fill
        
            let mylabel = VerticalAlignedLabel()
            mylabel.contentMode = .bottom
            
            
            mylabel.text = "-"+sports[i].uppercased()+"-"
            mylabel.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            mylabel.textColor = .black
            mylabel.textAlignment = .center
            mylabel.font = UIFont(name: "Futura-Bold", size: 20.0)
          
            
            let level1 = createNewButton(buttonName: "beginner")
            //level1.tag = index
            index += 1
            let level2 = createNewButton( buttonName: "average")
            //level2.tag = index
            index += 1
            let level3 = createNewButton(buttonName: "expert")
            //level3.tag = index
            index += 1
            //add bottom 3 elements
             mystack.addArrangedSubview(level1)
             mystack.addArrangedSubview(level2)
             mystack.addArrangedSubview(level3)
             mystack.spacing = 0.5
            
            
            mystackTest.addArrangedSubview(mylabel)//this tells me what it pertains to
            mystackTest.addArrangedSubview(mystack)

            
            levelsStack.addArrangedSubview(mystackTest)
            
            levelsStack.translatesAutoresizingMaskIntoConstraints = false
            
            index += 1
            i += 1
            print("SOLVED?",index)
        }
        checkOne()  //seems to work rn
        
        self.view.addSubview(levelsStack)
    }
   
    func createNewButton(buttonName: String) -> UIButton {
        let myButton = UIButton()
        // myButton.setImage(UIImage(named: buttonName), forState: UIControl.State.Normal)
        print("made a UIBUTTON")
        myButton.setTitle(buttonName, for: .normal)
       
        myButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        myButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        myButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        print("here \(myButton.tag)")
        self.buttonNames.append(buttonName)
        self.buttons.append(myButton)
        assignTag(b:myButton)
        return myButton
    }
    
    @objc func buttonClicked(button : UIButton){
      
        switch button.tag {
        case 0,1,2: //for 1st row
            if button.backgroundColor == #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1){
                
                
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            }else{
                button.backgroundColor = #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1)
                for i in 0..<3{
                    if i != button.tag {
                        buttons[i].backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    }
                }
            }
            
            levelPickmap[sports[0]] = button.currentTitle
        case 3,4,5:
            
            if button.backgroundColor == #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1){
                
                
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            }else{
                button.backgroundColor = #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1)
                for i in 3..<6{
                    if i != button.tag {
                        buttons[i].backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    }
                }
            }
            
            levelPickmap[sports[1]] = button.currentTitle
        case 6,7,8:
            if button.backgroundColor == #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1){
                
                
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            }else{
                button.backgroundColor = #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1)
                for i in 6..<9{
                    if i != button.tag {
                        buttons[i].backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    }
                }
            }
            
            levelPickmap[sports[2]] = button.currentTitle
        case 9,10,11:
            
            if button.backgroundColor == #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1){
                
                
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            }else{
                button.backgroundColor = #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1)
                for i in 9..<12{
                    if i != button.tag {
                        buttons[i].backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    }
                }
            }
            
            
            levelPickmap[sports[3]] = button.currentTitle
        case 12,13,14:
            
            if button.backgroundColor == #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1){
                
                
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            }else{
                button.backgroundColor = #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1)
                for i in 12..<15{
                    if i != button.tag {
                        buttons[i].backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    }
                }
            }
            
            
            levelPickmap[sports[4]] = button.currentTitle
        case 15,16,17:
            
            if button.backgroundColor == #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1){
                
                
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            }else{
                button.backgroundColor = #colorLiteral(red: 0.3296224177, green: 0.4158086181, blue: 0.4823732376, alpha: 1)
                for i in 15..<18{
                    if i != button.tag {
                        buttons[i].backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    }
                }
            }
            
            levelPickmap[sports[5]] = button.currentTitle    
        default:
            print("else")
        }
        var i = 0
        for _ in buttonNames{
           // print(buttonNames[i], "at\(i)")
            i += 1
        }
        
    }
    
    func assignTag(b : UIButton){
        var i = 0
        for _ in buttonNames{
            b.tag = i
            i += 1
        }
    }
    
    func createLevelsView(){
        var index = 0
        var i = 0
        for _ in sports{
            let mystack = UIStackView()
            mystack.axis = .horizontal
            mystack.distribution = .fillEqually
            mystack.alignment = .fill
            
            let mystackTest = UIStackView()
            mystackTest.axis = .vertical
            mystackTest.distribution = .fillEqually //change back to fillprop if fail
            mystackTest.alignment = .fill
            
            let mylabel = VerticalAlignedLabel()
            mylabel.contentMode = .bottom
            
            mylabel.text = "-"+sports[i].uppercased()+"-"
            mylabel.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            mylabel.textColor = .black
            mylabel.textAlignment = .center
            mylabel.font = UIFont(name: "Futura-Bold", size: 20.0)
            
            
            let level1 = createNewButton(buttonName: "beginner")
            //level1.tag = index
            index += 1
            let level2 = createNewButton( buttonName: "average")
            //level2.tag = index
            index += 1
            let level3 = createNewButton(buttonName: "expert")
            //level3.tag = index
            index += 1
            
            //add bottom 3 elements
            mystack.addArrangedSubview(level1)
            mystack.addArrangedSubview(level2)
            mystack.addArrangedSubview(level3)
            mystack.spacing = 0.5
            
            //add two parts for top(sport label) and bottom(levels buttons)
            mystackTest.addArrangedSubview(mylabel)//this tells me what it pertains to
            mystackTest.addArrangedSubview(mystack)
            
            //add one stack containing all elements for one sport
            levelsStack.addArrangedSubview(mystackTest)
            
            levelsStack.translatesAutoresizingMaskIntoConstraints = false
            
            index += 1
            i += 1
            print("SOLVED?",index)
        }
        checkOne()  //seems to work rn
        
        self.view.addSubview(levelsStack)
    }
    
    
    func checkOne(){
        if sports.count == 1{
            let mystack = UIStackView()
            mystack.axis = .horizontal
            mystack.distribution = .fillEqually
            mystack.alignment = .fill
            
            let mystackTest = UIStackView()
            mystackTest.axis = .vertical
            mystackTest.distribution = .fillProportionally
            mystackTest.alignment = .fill
            let mylabel = VerticalAlignedLabel()
            let mylabel2 = UILabel()
            let mylabel3 = UILabel()
            let mylabel4 = UILabel()
            mystack.addArrangedSubview(mylabel2)
            mystack.addArrangedSubview(mylabel3)
            mystack.addArrangedSubview(mylabel4)
            mystackTest.addArrangedSubview(mylabel)
            mystackTest.addArrangedSubview(mystack)
            levelsStack.addArrangedSubview(mystackTest)
            levelsStack.translatesAutoresizingMaskIntoConstraints = false
        }
        self.view.addSubview(levelsStack)
    }
    
    fileprivate func setBackground() {
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
    }

func buttonAction(sender: UIButton!) {
    print("Button tapped")
}

class VerticalAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        var newRect = rect
        switch contentMode {
        case .top:
            newRect.size.height = sizeThatFits(rect.size).height
        case .bottom:
            let height = sizeThatFits(rect.size).height
            newRect.origin.y += rect.size.height - height
            newRect.size.height = height
        default:
            ()
        }
        super.drawText(in: newRect)
    }
}
