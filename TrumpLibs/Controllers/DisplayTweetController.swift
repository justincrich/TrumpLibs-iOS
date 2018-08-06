//
//  DisplayTweetController.swift
//  TrumpLibs
//
//  Created by Justin on 7/25/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit

class DisplayTweetController: UIViewController {

    var libType: String = "Fake Trump"
    
    var tweet:Tweet
    
    private lazy var titleLabel: Title = {
        let label = Title()
        label.text = "The latest from \(libType)"
        return label
    }()
    
    lazy var shareTweetButton: BigButton = {
        let button = BigButton(label:"Share", color:.secondaryAccent)
        button.addTarget(self, action: #selector(DisplayTweetController.shareTweet), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.widthAnchor.constraint(greaterThanOrEqualToConstant:300).isActive = true
        return button
    }()
    
    lazy var newTweetButton: BigButton = {
        let button = BigButton(label: "New Tweet", color: .accent)
        button.addTarget(self, action: #selector(DisplayTweetController.startNewTweet), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.widthAnchor.constraint(greaterThanOrEqualToConstant:300).isActive = true
        return button
    }()
    
    private lazy var tweetCard: TweetCard = {
        let card = TweetCard(for:self.tweet)
        return card
    }()
    
    
    required init(for tweet:Tweet) {
        self.tweet = tweet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(titleLabel)
        view.addSubview(tweetCard)
        let buttonContainer = UIStackView()
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addArrangedSubview(shareTweetButton)
        buttonContainer.addArrangedSubview(newTweetButton)
        buttonContainer.spacing = 10
        view.addSubview(buttonContainer)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -175),
            tweetCard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tweetCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tweetCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tweetCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            tweetCard.widthAnchor.constraint(lessThanOrEqualToConstant: 650),
            buttonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            buttonContainer.widthAnchor.constraint(equalToConstant: 300),
            shareTweetButton.widthAnchor.constraint(equalTo: newTweetButton.widthAnchor),
            
        ])
        
    }
    
    //MARK - UI Interactions
    
    @objc func startNewTweet(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: MenuController.self) {
                _ =  self.navigationController!.popToViewController(controller, animated: false)
                break
            }
        }
    }
    
    @objc func shareTweet(){
        let sharableImage = tweetCard.generateImage()
        let activityView = UIActivityViewController(activityItems: [sharableImage], applicationActivities: [])
        activityView.popoverPresentationController?.sourceView = self.view
        present(activityView, animated: true)
        //TODO - Add success/failure notification
    }
    


}
