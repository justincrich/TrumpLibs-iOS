//
//  TweetCard.swift
//  TrumpLibs
//
//  Created by Justin on 7/25/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit


class TweetCard: UIView {
    
    var tweet:Tweet
    
    var tweetText: NSMutableAttributedString = NSMutableAttributedString(string: "")
    
    
    
    lazy var profileImage: UIImageView = {
        var image = #imageLiteral(resourceName: "profile_image")
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    lazy var nameLabel:UILabel = {
        let name = "Donald J. Trump"
        var label = UILabel()
        label.text = name
        label.textColor = .fontDark
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var handleLabel:UILabel = {
        let name = "@fakeDonaldTrump"
        var label = UILabel()
        label.text = name
        label.textColor = .fontMuted
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tweetContent: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var seeOriginalButton:UIButton = {
        let button = UIButton()
        button.setTitle("see original", for: .normal)
        button.setTitleColor(.accent, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(TweetCard.showOriginalTweet), for: .touchUpInside)
        return button
    }()
    
    required init(for tweet:Tweet) {
        
        self.tweet = tweet
        super.init(frame: CGRect.zero)
        if let words = self.tweet.wordArray {
            self.tweetText = swapFields(for: words)
            self.tweetContent.attributedText = self.tweetText
            
        }else{
            
        }
        didLoad()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func didLoad(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.addSubview(profileImage)
        self.addSubview(nameLabel)
        self.addSubview(handleLabel)
        self.addSubview(seeOriginalButton)
        self.addSubview(tweetContent)

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            handleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            handleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            tweetContent.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            tweetContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tweetContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            seeOriginalButton.topAnchor.constraint(equalTo: tweetContent.bottomAnchor, constant: 10),
            seeOriginalButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            seeOriginalButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        self.sizeToFit()

    }
    
    //MARK - Actions
    @objc func showOriginalTweet(){
        
        
        
        if let buttonName = self.seeOriginalButton.titleLabel?.text, buttonName == "see original"{
            self.seeOriginalButton.setTitle("see your lib", for: .normal)
            self.tweetContent.attributedText = NSMutableAttributedString(string: self.tweet.text,attributes:[NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16)])
        }else{
            self.seeOriginalButton.setTitle("see original", for: .normal)
            self.tweetContent.attributedText = self.tweetText
        }
        
        print("return")
    }
    
    //MARK - Internal transforms
    private func swapFields(for words:[Word]) -> NSMutableAttributedString{
        
        let output = NSMutableAttributedString(string: "")
        for word in words{
            var attrs: [NSAttributedStringKey:Any]
            var attributedString: NSMutableAttributedString
            if let field = word.alternateTextField, let text = field.text, text != "" {
                attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor : UIColor.secondaryAccent]
                attributedString = NSMutableAttributedString(string:text,attributes:attrs)
                
            }else{
                attrs = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16),
                         NSAttributedStringKey.foregroundColor:UIColor.fontDark
                ]
                attributedString = NSMutableAttributedString(string:word.text,attributes:attrs)
            }
            output.append(attributedString)
        }
        return output
        
    }
    
    func generateImage() -> UIImage?{

        let dimensions = CGRect(x: 0, y: 0, width: self.bounds.width+10, height: self.bounds.height+10)
        
        let exportedView = UIView()
        exportedView.translatesAutoresizingMaskIntoConstraints = false
        exportedView.backgroundColor = .background
        
        let exportedCard = TweetCard(for: self.tweet)
        exportedCard.seeOriginalButton.isHidden = true
        
        exportedView.addSubview(exportedCard)

        exportedCard.leadingAnchor.constraint(equalTo: exportedView.leadingAnchor, constant: 5).isActive = true
        exportedCard.trailingAnchor.constraint(equalTo: exportedView.trailingAnchor, constant: -5).isActive = true
        exportedCard.topAnchor.constraint(equalTo: exportedView.topAnchor, constant: 5).isActive = true
        exportedCard.bottomAnchor.constraint(equalTo: exportedView.bottomAnchor, constant: -5).isActive = true
        
        exportedView.widthAnchor.constraint(equalToConstant: dimensions.width).isActive = true
        exportedView.heightAnchor.constraint(equalToConstant: dimensions.height).isActive = true
        
        let renderer = UIGraphicsImageRenderer(bounds: dimensions )
        let image = renderer.image{
            ctx in
            
            exportedView.drawHierarchy(in: dimensions, afterScreenUpdates: true)
        }
        
        return image
        
    }
    
    

}
