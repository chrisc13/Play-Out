//
//  EventsViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 9/29/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Events"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
    }
    func setupView(){
//        titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
    }


}
