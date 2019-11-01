//
//  roundButton.swift
//  Play Out
//
//  Created by Chris Carbajal on 5/24/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit

class roundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
    }
}
class leafButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/1.5
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
       // self.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        
        
        self.layer.shadowColor = UIColor.black.cgColor
      
        
    }
}

class circleButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.layer.masksToBounds = false
      //  self.layer.cornerRadius = self.bounds.size.width/10;
        //self.layer.cornerRadius = 25
        
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        
    
        
    }
}


class circlularView: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        self.clipsToBounds = true
        
        
        
        
    }
}


    class hollowRound: UIButton {
        
        override func awakeFromNib() {
            super.awakeFromNib()
            //self.layer.masksToBounds = false
            //  self.layer.cornerRadius = self.bounds.size.width/10;
            //self.layer.cornerRadius = 25
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = 25
            self.tintColor = UIColor.black
            
        }
    }
@IBDesignable class RoundButton : UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
}

@IBDesignable
extension UIImageView
{
    private struct AssociatedKey
    {
        static var rounded = "UIImageView.rounded"
    }
    
    @IBInspectable var rounded: Bool
        {
        get
        {
            if let rounded = objc_getAssociatedObject(self, &AssociatedKey.rounded) as? Bool
            {
                return rounded
            }
            else
            {
                return false
            }
        }
        set
        {
            objc_setAssociatedObject(self, &AssociatedKey.rounded, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            layer.cornerRadius = CGFloat(newValue ? 1.0 : 0.0)*min(bounds.width, bounds.height)/2
        }
    }
}
    
    
    /*let button = UIButton(type: .custom)
    button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
    button.layer.cornerRadius = 0.5 * button.bounds.size.width
    button.clipsToBounds = true
    button.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
    button.addTarget(self, action: #selector(thumbsUpButtonPressed), for: .touchUpInside)
    view.addSubview(button)*/

