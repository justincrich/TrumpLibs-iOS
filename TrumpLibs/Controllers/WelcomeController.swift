//
//  ViewController.swift
//  TrumpLibs
//
//  Created by Justin on 7/18/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    
    @IBOutlet weak var Button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        Button.backgroundColor = .accent
        Button.setTitleColor(.fontLight, for: .normal)
        Button.layer.cornerRadius = 15
        subtitle.textColor = .fontLight
        header.textColor = .fontLight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPressPlay(_ sender: Any) {
        let menu = MenuController()
        navigationController?.pushViewController(menu, animated: true)
    }
    
}

