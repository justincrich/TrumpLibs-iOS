//
//  Header.swift
//  TrumpLibs
//
//  Created by Justin on 7/26/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit

class Title:UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.didLoad()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.didLoad()
    }
    private func didLoad(){
        self.textColor = .fontLight
        self.font = UIFont.preferredFont(forTextStyle: .title1)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.textAlignment = .center
    }
}
