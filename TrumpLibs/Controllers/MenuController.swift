//
//  MenuController.swift
//  TrumpLibs
//
//  Created by Justin on 7/19/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    private enum LibViewError: Error{
        case noTweets
        
        var message: String{
            switch self{
            case .noTweets:
                return "No Tweets Found"
            }
        }
    }
    

    // MARK: - User Interface Properties
    lazy var spinner: UIView = {
       let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .twitterBlue
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(white:1, alpha:0.9)
        container.addSubview(spinner)
        container.widthAnchor.constraint(equalToConstant: 100).isActive = true
        container.heightAnchor.constraint(equalToConstant: 100).isActive = true
        container.layer.cornerRadius = 25
        spinner.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        return container
    }()
    
    lazy var headline:UILabel = {
        let label = UILabel()
        label.text = "What type of Trump do you want to Lib?"
        label.font = .titleXL
        label.textColor = .fontLight
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.widthAnchor.constraint(equalToConstant: 350).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    lazy var backgroundImg: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "background")
        return imageView
    }()
    
    lazy var classicButton: BigButton = {
        let button = BigButton(label: "Classic Trump", color: .twitterBlue)
        button.addTarget(self, action:#selector(MenuController.goClassicTrump), for: .touchUpInside)
        return button
    }()
    
    lazy var presidentialButton: BigButton = {
        let button = BigButton(label: "Presidential Trump", color: .red)
        button.addTarget(self, action: #selector(MenuController.goPresidentialTrump), for: .touchUpInside)
        return button
    }()
    
    lazy var broButton: BigButton = {
        let button = BigButton(label: "Bro Trump", color: .secondaryAccent)
        button.addTarget(self, action: #selector(MenuController.goPresidentialTrump), for: .touchUpInside)
        return button
    }()
    

    init(){
        super.init(nibName:nil,bundle:nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let buttonContainer = UIStackView(arrangedSubviews: [presidentialButton,broButton,classicButton])
        buttonContainer.axis = .vertical
        buttonContainer.spacing = 30
        buttonContainer.alignment = .fill
        buttonContainer.distribution = .fill
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.spinner.isHidden = true
        
        view.addSubview(backgroundImg)
        view.addSubview(headline)
        view.addSubview(buttonContainer)
        view.addSubview(spinner)
        
        
        //Body Constraints
        NSLayoutConstraint.activate([
            headline.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            backgroundImg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImg.heightAnchor.constraint(equalToConstant: 300),
            backgroundImg.widthAnchor.constraint(equalToConstant: 300),
           buttonContainer.widthAnchor.constraint(equalToConstant: 350),
           buttonContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           buttonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           spinner.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func goClassicTrump(){
        loadTweet(for: .classic)
    }

    
    @objc func goPresidentialTrump(){
        loadTweet(for: .presidential)
    }
    
    @objc func broTrump(){
        loadTweet(for: .bro)
    }
    
    private func loadTweet(for type:TweetType){
        
//        if let view = self.viewIfLoaded {
//            view.addSubview(spinner)
////            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
////            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        }
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        let loadingSpinner = self.spinner.subviews[0] as? UIActivityIndicatorView
        loadingSpinner?.startAnimating()
        self.spinner.isHidden = false
        TweetLoader().retrieveTweets(of: type).done{
            tweets in
            //print(type(of: tweets))
            if var tweets = tweets as? [Tweet]{
                let libber = Libber()
                var tweet:Tweet?
                while tweets.count > 0 {

                    let (tweetIndex, selectedTweet) = libber.randomTweet(from: tweets)

                    if let pos = selectedTweet.wordArray, pos.count > 0 {
                        tweet = selectedTweet
                        break
                    }

                    tweets.remove(at: tweetIndex)
                }
                if let tweet = tweet {
                    loadingSpinner?.stopAnimating()
                    self.spinner.isHidden = true
                    let mlcontroller = MadLibFormController(with:tweet)
                    self.navigationController?.pushViewController(mlcontroller, animated: false)
                }else{
                    //TODO - Send Message when not avaliable
                    print("no tweets avaliable")
                }
            }
        }.catch{
            error in
            //TODO - handle error states for fetching tweets
            print(error)
        }.finally {
            loadingSpinner?.stopAnimating()
            self.spinner.isHidden = true
        }
    }

    


}
