//
//  ProfileViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 7/8/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import Material
class MyCell: UICollectionViewCell {
    
    let myLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 64)
        label.textAlignment = .center
        label.fontSize = 16
        label.backgroundColor = #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1)
        label.textColor = .gray
        return label
    }()
    
    override func awakeFromNib() {
        self.addSubview(self.myLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    func addViews(){
        backgroundColor = #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1)
        addSubview(myLabel)
        myLabel.center.x = frame.center.x/4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewProfileController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentUser?.sports.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayCell", for: indexPath) as! MyCell
        cell.myLabel.text = currentUser?.sports[indexPath.row]
        //cell.contentView = .center
        
        cell.myLabel.sizeToFit()
       // cell.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
 
        return cell
    }
    
    var userImage : UIImage?
    var currentUser : Users?
    var collectionView: UICollectionView?
    var lowStackView : UIStackView?
    var stackView : UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
        setupCollection()
        setupStack()
        setupView()
        
        guard let c = collectionView else{print("nope")
            return
        }
        c.flashScrollIndicators()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let c = collectionView else{print("nope")
            return
        }
        c.flashScrollIndicators()
    }
    
    func setupCollection() {
        let frame = self.view.frame
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.collectionView?.layer.cornerRadius = 15.0
        self.collectionView?.backgroundColor = #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1)
        self.collectionView?.register(MyCell.self, forCellWithReuseIdentifier: "PlayCell")
        collectionView?.alwaysBounceVertical = false
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = lowStackView?.frame.width ?? 0
        let h = lowStackView?.frame.height ?? 0
        return CGSize(width: w/4, height: h/2)
    }
    
    func setupStack(){
        guard let user = currentUser else {return }
        print("user name is\(user.name)")
        let userImageView = UIImageView(image: userImage)
        let editBttn = UIButton()
        editBttn.backgroundColor = #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1)
        
        userImageView.addSubview(editBttn)
        editBttn.translatesAutoresizingMaskIntoConstraints = false
        editBttn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        editBttn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        editBttn.topAnchor.constraint(equalTo: userImageView.topAnchor, constant: 45).isActive = true
        editBttn.trailingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: -10).isActive = true
        
        editBttn.setNeedsLayout()
        editBttn.layoutIfNeeded()
        editBttn.layer.cornerRadius = 0.5 * editBttn.bounds.size.width
        editBttn.setImage(UIImage(named:"icons8-edit.png"), for: .normal)
        editBttn.clipsToBounds = true
        let nameBttn = createButton(title: user.name, fontSize: 20, darkText: true)
        
        guard let font = UIFont(name:"Chalkduster",size:25) else {return}
        
        nameBttn.titleLabel?.font = font
        let cityBttn = createButton(title: user.city, fontSize: 16, darkText: false)
        let ageBttn = createButton(title: user.age.description, fontSize: 16, darkText: false)
        
      
        
        
        lowStackView = UIStackView(arrangedSubviews: [cityBttn,ageBttn])
        
        guard let lowStackView = lowStackView else{return}
        lowStackView.alignment = .fill
        lowStackView.axis = .horizontal
        lowStackView.distribution = .fillEqually
       
        
        stackView = UIStackView(arrangedSubviews: [userImageView,nameBttn, lowStackView])
        guard let stackView = stackView else{return}
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
       //stackView.customize(backgroundColor: #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1), radiusSize: 20.0)
       // stackView.addBackground(color: #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1))
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupView(){
        guard let lowStackView = lowStackView else {print("cant make it")
            return}
        guard let stackView = stackView else {print("cant make it")
            return}
        guard let collectionView = collectionView else {print("cant make it")
            return}
        
       
        lowStackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(lowStackView)
        stackView.addBackground(color: #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1))

    
        view.addSubview(stackView)
        let sH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stackView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["stackView":stackView])
        let sV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stackView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue:0), metrics: nil, views: ["stackView":stackView])
        view.addConstraints(sH)
        view.addConstraints(sV)
        
        self.view.addSubview(stackView)
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
    
   
}

extension ViewProfileController {
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
        self.currentUser = user //new instance of user class with the loaded attributed from db
        self.userImage = resized
    }
}


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

extension UIStackView {
    func customize(backgroundColor: UIColor = .clear, radiusSize: CGFloat ) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = backgroundColor
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
        
        subView.layer.cornerRadius = radiusSize
        subView.layer.masksToBounds = true
        subView.clipsToBounds = true
    }
}


extension UIStackView {
    
    func addBackground(color: UIColor) {
        let subview = UIView(frame: bounds)
        subview.backgroundColor = color
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subview.layer.cornerRadius = 15.0
        insertSubview(subview, at: 0)
    }
    
}

extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
}
