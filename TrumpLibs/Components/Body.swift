//
//  Label.swift
//  TrumpLibs
//
//  Created by Justin on 7/27/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit

class Body: UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.didLoad()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.didLoad()
    }
    private func didLoad(){
        self.textColor = .fontDark
        self.font = UIFont.preferredFont(forTextStyle: .body)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.textAlignment = .left
    }

}
