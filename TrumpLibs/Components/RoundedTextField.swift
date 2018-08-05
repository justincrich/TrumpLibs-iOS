//
//  RoundedTextField.swift
//  TrumpLibs
//
//  Created by Justin on 7/24/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {

    
    
    
    required init(_ placeholder:String){
        
        
        super.init(frame:.zero)
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        self.borderStyle = .none
        self.autocapitalizationType = .none
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.borderWidth = 4.0
        self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true

        self.translatesAutoresizingMaskIntoConstraints = false
        self.attributedPlaceholder = NSAttributedString(
                     string: placeholder,
                     attributes:[NSAttributedStringKey.foregroundColor:UIColor.fontLight]
        )
        
        self.textColor = .fontLight
        self.tintColor = .fontLight


    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
