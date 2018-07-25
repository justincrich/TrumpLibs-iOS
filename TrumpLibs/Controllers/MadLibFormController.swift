//
//  MadLibFormController.swift
//  TrumpLibs
//
//  Created by Justin on 7/19/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit

class MadLibFormController: UIViewController {
    
    
    
    
    // MARK: - UI Elements
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Fill out the fields below and your words will replace terms in Trump's tweet:"
        title.textColor = .fontLight
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return title
    }()
    
    lazy var submitButton: BigButton = {
        let submitButton = BigButton(label: "Submit", color: .accent)
        submitButton.addTarget(self, action: #selector(MadLibFormController.submitForm), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false

        return submitButton
    }()
    
    var selectedTweet: Tweet?
    var fields: [RoundedTextField] = []
    
    lazy var form: UIStackView = {
        var partsOfSpeech = self.selectedTweet?.textPartsOfSpeech ?? []
        fields = partsOfSpeech.map({
            (partOfSpeech:LibberOption) -> RoundedTextField in
            let field = RoundedTextField(for:partOfSpeech)
            field.widthAnchor.constraint(equalToConstant:300).isActive = true
            return field
        })
       let form = UIStackView(arrangedSubviews: fields)
        form.spacing = 30
        form.translatesAutoresizingMaskIntoConstraints = false
        form.axis = .vertical
        form.alignment = .center
        
        return form
    }()
    
    lazy var notification: Notification = {
        let toast = Notification()
        toast.layer.zPosition = 1
        return toast
    }()
    
    lazy var backgroundImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "background")
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return imageView
    }()
    
    
    //MARK: Error Enums
    enum LibControllerError:Error{
        
        case incompleteForm
        
        var message: String{
            switch self{
            case .incompleteForm:
                return Messages.incompleteForm.rawValue
            }
        }
    }
    
    //MARK: Lifecycle Functions
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        let display = DisplayTweetController()
        navigationController?.pushViewController(display, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(backgroundImg)
        view.addSubview(titleLabel)
        view.addSubview(form)
        view.addSubview(submitButton)
        

      
        
        NSLayoutConstraint.activate([
            
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            form.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            form.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
            backgroundImg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            submitButton.widthAnchor.constraint(equalToConstant:300),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        
    }

    //MARK: Action Functions
    @objc func submitForm() {        
        do{
            var userInput = try processFields(with:fields)

            
            if var tweet = self.selectedTweet{
                tweet.textUserInput = userInput
            }
            
        }catch {
            if let libError = error as? LibControllerError{
                
                view.addSubview(self.notification)
                self.notification.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                self.notification.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
                self.notification.label.text = libError.message
                
                DispatchQueue.main.asyncAfter(deadline: .now()+3){
                    self.notification.removeFromSuperview()
                }
                
                for field in fields {
                    field.layer.borderColor =  field.text != "" ? UIColor.white.cgColor : UIColor.red.cgColor
                }
                
            }
        }
    }
    
    private func processFields(with inputFields:[RoundedTextField]) throws ->[String]{
    
    var textContents: [String] = []
        
    for field in inputFields{
        
        if field.text != "" {
            textContents.append(field.text ?? "")
        }else{
            throw LibControllerError.incompleteForm
        }
    }
    return textContents

    }
}

