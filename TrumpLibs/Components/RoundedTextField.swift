//
//  RoundedTextField.swift
//  TrumpLibs
//
//  Created by Justin on 7/24/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let partOfSpeech: LibberOption
    
//    lazy var field: UITextField = {
//        let newField = UITextField()
//
//        return newField
//    }()
    
    required init(for partOfSpeech: LibberOption){
        
        self.partOfSpeech = partOfSpeech
        
        super.init(frame:.zero)
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        self.borderStyle = .none
        self.autocapitalizationType = .none
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.borderWidth = 4.0
        self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let placeholderText = formatPlaceholder(self.partOfSpeech.tag.rawValue)
        
        self.attributedPlaceholder = NSAttributedString(
            string:placeholderText,
            attributes:[NSAttributedStringKey.foregroundColor:UIColor.fontLight]
        )
        self.textColor = .fontLight
        self.tintColor = .fontLight

    }
    
    private func formatPlaceholder(_ unformattedText: String)->String{
        switch(unformattedText){
        case "PersonalName":
            return "Person"
        case "PlaceName":
            return "Place"
        default:
            return unformattedText
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
