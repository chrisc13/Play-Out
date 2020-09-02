//
//  ButtonView.swift
//  Play Out
//
//  Created by Chris Carbajal on 9/3/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import Foundation
import UIKit
 
class ButtonsView: UIView {
    
    private var scrollView: UIScrollView?
    
    @IBInspectable
    var wordsArray: [String] = [String]() {
        didSet {
            createButtons()
        }
    }
    
    private func createButtons() {
        scrollView?.removeFromSuperview()
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.addSubview(scrollView!)
        scrollView!.backgroundColor = UIColor.gray
        
        let padding: CGFloat = 10
        var currentWidth: CGFloat = padding
        for text in wordsArray {
            let button = UIButton(frame: CGRect(x:currentWidth, y: 0.0, width: 100, height: self.frame.size.height))
            button.setTitle(text, for: .normal)
            button.sizeToFit()
            let buttonWidth = button.frame.size.width
            currentWidth = currentWidth + buttonWidth + padding
            scrollView!.addSubview(button)
        }
        scrollView!.contentSize = CGSize(width:currentWidth,height:scrollView!.frame.size.height)
    }
}
