//
//  Fonts.swift
//  TrumpLibs
//
//  Created by Justin on 7/19/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    static var button: UIFont? = {
       var font = UIFont(name:"HelveticaNeue-Bold",size:20)
        
        return font
    }()
    static var titleXL = UIFont(name:"HelveticaNeue", size:34)
    static var titleL = UIFont(name:"HelveticaNeue", size:28)
    static var titleS = UIFont(name:"HelveticaNeue", size:20)
    static var body = UIFont(name:"HelveticaNeue", size:17)
    static var subhead = UIFont(name:"HelveticaNeue", size:15)
    static var caption = UIFont(name:"HelveticaNeue", size:12)
}
