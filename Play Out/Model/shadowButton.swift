//
//  shadowButton.swift
//  Play Out
//
//  Created by Chris Carbajal on 5/24/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit

class shadowButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        //self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = UIColor.black.cgColor
        //below  is for drop shadow
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        //changw top for a different shadow appearance
        
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
    }

}
