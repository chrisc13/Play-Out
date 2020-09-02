//
//  ProfilePictureViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 7/8/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit
import CircleMenu

class ProfilePictureViewController: UIViewController {
    
    let items: [(icon: String, color: UIColor)] = [
        ("icons8-home", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ("icons8-near_me", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
        ("icons8-cloud_user_group", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("icons8-test_account", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
    ]
    
    
    /*
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 9
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        return
    }
    

  
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
        
    }()
    
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = CircleMenu(
            frame: CGRect(x: 200, y: 200, width: 15, height: 15),
            normalIcon:"icons8-menu_filled",
            selectedIcon:"icons8-home_filled",
            buttonsCount: 4,
            duration: 4,
            distance: 120)
            view.addSubview(button)
        
        // Do any additional setup after loading the view.
    }
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}
