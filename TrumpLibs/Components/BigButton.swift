//
//  BigButton.swift
//  TrumpLibs
//
//  Created by Justin on 7/19/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit

class BigButton: UIButton {
    /*
     lazy var classicButton: UIButton = {
     let button = UIButton(type:.system)
     button.translatesAutoresizingMaskIntoConstraints = false
     let title = "Lib Classic Trump"
     button.setTitle("Lib Classic Trump", for: .normal)
     button.setTitleColor(.fontLight, for: .normal)
     button.titleLabel?.font = .button
     button.backgroundColor = .twitterBlue
     button.addTarget(self, action: #selector(MenuController.goClassicTrump), for: .touchUpInside)
     button.widthAnchor.constraint(equalToConstant: 350).isActive = true
     button.heightAnchor.constraint(equalToConstant: 60).isActive = true
     
     return button
     }()
     */
    
    required init(label text:String, color colorStyle:UIColor){
        super.init(frame:.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(text,for:.normal)
        self.setTitleColor(.fontLight, for: .normal)
        self.titleLabel?.font = .button
        self.backgroundColor = colorStyle
        self.layer.cornerRadius = 10
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
