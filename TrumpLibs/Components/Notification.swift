//
//  Toast.swift
//  TrumpLibs
//
//  Created by Justin on 7/25/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit

class Notification
: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var label: UILabel = {
        var label = UILabel()
        label.text = "Test"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func didLoad(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        self.widthAnchor.constraint(equalToConstant: 350).isActive = true
        self.heightAnchor.constraint(equalToConstant: 75).isActive = true
        self.layer.cornerRadius = 15
        self.addSubview(self.label)
        self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
    }
    
}
