//
//  SportsSelectViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 5/23/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit

class SportsSelectViewController: UIViewController {

    
    @IBOutlet weak var myStack: UIStackView!
    
    
    var sportsSelected = [String]()
    var uid : String?
    var profImage : UIImage? = nil
    var name : String?
    var city : String?
    var age : Int?
    var gender : String?
    

    var uprightCount = 1
    var upleftCount = 1
    var midleftCount = 1
    var midrightCount = 1
    var botleftCount = 1
    var botrightCount = 1
    
    @IBOutlet weak var nextBtn: roundButton!
    
    @IBAction func nextBttn(_ sender: Any) {
        var userHasSelected = false
        
        if checkCount(num: uprightCount){
            userHasSelected = true
            sportsSelected.append("Football")
        }
        if checkCount(num: upleftCount){
            userHasSelected = true
            sportsSelected.append("Soccer")
        }
        if checkCount(num: midleftCount){
            userHasSelected = true
            sportsSelected.append("Baseball")
        }
        if checkCount(num: midrightCount){
            userHasSelected = true
            sportsSelected.append("Running")
        }
        if checkCount(num: botleftCount){
            userHasSelected = true
            sportsSelected.append("Basketball")
        }
        if checkCount(num: botrightCount){
            userHasSelected = true
            sportsSelected.append(bottomrightBtn.currentTitle ?? "Other")
        }
        
        
        if userHasSelected {
            print("All elemens;")
            for element in sportsSelected {
                print(element)
            }
            
            
            self.performSegue(withIdentifier: "toLvl", sender: Any?.self)
        }else{
            Alert.showBasicAlert(on: self, with: "Incomplete", message: "Choose or input a sport", actionName: "Ok")
            
        }
        
        
    }
    
    
    
    @IBOutlet weak var upleftBtn: UIButton!
    
    @IBAction func upleftBttn(_ sender: Any) {
        upleftCount += 1
        let b = checkCount(num: upleftCount) //will keep track of every even value(click - unclick)
        if b {
            upleftBtn.backgroundColor = #colorLiteral(red: 0.330473721, green: 0.4147269726, blue: 0.4814503193, alpha: 1) //#colorLiteral(red: 0.3333, green: 0.5686, blue: 0.7294, alpha: 0.5) /* #5591ba */
           

        }else {
            upleftBtn.backgroundColor = #colorLiteral(red: 0.8431, green: 0.8431, blue: 0.8431, alpha: 1)
        }
        print("here\(b)")
    }
    
    @IBOutlet weak var uprightBtn: UIButton!
    
    
    @IBAction func uprightBttn(_ sender: Any) {
        uprightCount += 1
        let b = checkCount(num: uprightCount)
        if b {
            uprightBtn.backgroundColor = #colorLiteral(red: 0.330473721, green: 0.4147269726, blue: 0.4814503193, alpha: 1) //#colorLiteral(red: 0.3333, green: 0.5686, blue: 0.7294, alpha: 0.5) /* #5591ba */

            
        }else {
            uprightBtn.backgroundColor = #colorLiteral(red: 0.8431, green: 0.8431, blue: 0.8431, alpha: 1)
        }
        print("here\(b)")
    }
    
    @IBOutlet weak var midleftBtn: UIButton!
   
    
    @IBAction func midleftBttn(_ sender: Any) {
        midleftCount += 1
        let b = checkCount(num: midleftCount)
        if b {
            midleftBtn.backgroundColor = #colorLiteral(red: 0.330473721, green: 0.4147269726, blue: 0.4814503193, alpha: 1) //#colorLiteral(red: 0.3333, green: 0.5686, blue: 0.7294, alpha: 0.5) /* #5591ba */

            
        }else {
            midleftBtn.backgroundColor = #colorLiteral(red: 0.8431, green: 0.8431, blue: 0.8431, alpha: 1)
        }
        print("here\(b)")
    }
    
    
    @IBOutlet weak var midrightBtn: UIButton!
    
    
    
    @IBAction func midrightBttn(_ sender: Any) {
        midrightCount += 1
        let b = checkCount(num: midrightCount)
        if b {
            midrightBtn.backgroundColor = #colorLiteral(red: 0.330473721, green: 0.4147269726, blue: 0.4814503193, alpha: 1)//#colorLiteral(red: 0.3333, green: 0.5686, blue: 0.7294, alpha: 0.5) /* #5591ba */
        

            
        }else {
            midrightBtn.backgroundColor = #colorLiteral(red: 0.8431, green: 0.8431, blue: 0.8431, alpha: 1)
        }
        print("here\(b)")
    }
    
    
    
    @IBOutlet weak var bottomleftBtn: UIButton!
    
    
    @IBAction func bottomleftBttn(_ sender: Any) {
        botleftCount += 1
        let b = checkCount(num: botleftCount)
        if b {
            bottomleftBtn.backgroundColor = #colorLiteral(red: 0.330473721, green: 0.4147269726, blue: 0.4814503193, alpha: 1)//#colorLiteral(red: 0.3333, green: 0.5686, blue: 0.7294, alpha: 0.5) /* #5591ba */

            
        }else {
            bottomleftBtn.backgroundColor = #colorLiteral(red: 0.8431, green: 0.8431, blue: 0.8431, alpha: 1)
        }
        print("here\(b)")
    }
    
    
    @IBOutlet weak var bottomrightBtn: UIButton!
    
    
    @IBAction func bottomrightBttn(_ sender: Any) {
        botrightCount += 1
        let b = checkCount(num: botrightCount)
        if b {
            bottomrightBtn.backgroundColor = #colorLiteral(red: 0.330473721, green: 0.4147269726, blue: 0.4814503193, alpha: 1)//#colorLiteral(red: 0.3333, green: 0.5686, blue: 0.7294, alpha: 0.5) /* #5591ba */

            
            let addAlert = UIAlertController(title: "Input Sport Name", message: "", preferredStyle: .alert)
            //addAlert.addAction(UIAlertAction(title: actionname, style: .default, handler: nil))
            
            addAlert.addTextField(configurationHandler: { textField in
                textField.keyboardType = .default
                //textField.keyboard
                textField.returnKeyType = .go
                textField.autocapitalizationType = .sentences
                textField.placeholder = "enter here"
                
            })
            
            addAlert.addAction(UIAlertAction(title: "Enter", style: .default, handler: { [weak addAlert] (_) in
                let textField = addAlert!.textFields![0] // Force unwrapping because we know it exists.
                if textField.text == ""{
                    textField.text = "Other"
                }
                
                
                //print("Text field: \(textField.text)")
                self.bottomrightBtn.setTitle(textField.text, for: .normal)
            }))
            
            self.present(addAlert, animated: true)
            
            
        }else {
            bottomrightBtn.backgroundColor = #colorLiteral(red: 0.8431, green: 0.8431, blue: 0.8431, alpha: 1)
        }
        print("here\(b)")
       
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
          //  self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        setBorders()
            
            
            
           /* print("look at al those..",uid?.description ?? 0, profImage?.description,
              name, city, age, gender)*/
            
        // Do any additional setup after loading the view.
    }
    
    func setShadow(button: UIButton, w: Double, h :Double){
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.shadowOffset = CGSize(width: w, height: h)
        button.layer.borderWidth = 2
    }
    
    func setBorders(){
        setShadow(button: uprightBtn, w: 2.0, h: -2.0)
        setShadow(button: upleftBtn, w: -2.0, h: -2.0)
        setShadow(button: midleftBtn, w: -2.5, h: 0.0)
        setShadow(button: midrightBtn, w: 2.5, h: 0.0)
        setShadow(button: bottomleftBtn, w: -2.5, h: 2.5)
        setShadow(button: bottomrightBtn, w: 2.5, h: 2.5)
    }
    
    func checkCount(num:Int)->Bool{
        if num % 2 == 0 {
            return true
        }else{
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toLvl"){
            let dest = segue.destination as! SportLevelViewController
            
            dest.sports = sportsSelected
            dest.uid = uid
            dest.profImage = profImage
            dest.name = name
            dest.city = city
            dest.age = age
            dest.gender = gender
            
        }
    }
    
    fileprivate func setBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "b2.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
     
        self.view.insertSubview(backgroundImage, at: 0)
    }
 

}


