//
//  MadLibFormController.swift
//  TrumpLibs
//
//  Created by Justin on 7/19/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import UIKit


extension Array {
    
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}

class MadLibFormController: UIViewController {
    
    // MARK: - UI Elements
    
    lazy var titleLabel: Title = {
        let title = Title()
        title.text = "Fill out the fields below and your words will replace terms in Trump's tweet:"
        title.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return title
    }()
    
    lazy var submitButton: BigButton = {
        let submitButton = BigButton(label: "Submit", color: .accent)
        submitButton.addTarget(self, action: #selector(MadLibFormController.submitForm), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.widthAnchor.constraint(greaterThanOrEqualToConstant:300).isActive = true
        return submitButton
    }()
    
    var selectedTweet: Tweet
    
    
    lazy var form: UIStackView = {
        
        var wordFields = self.selectedTweet.wordArray?.reduce([RoundedTextField](), {
            (aggregator, word) in
            var wordFields = aggregator
            
            if let field = word.alternateTextField as RoundedTextField?{
                field.widthAnchor.constraint(equalToConstant: 300).isActive = true
                wordFields.append(field)
            }
            
            return wordFields
            
        }) ?? []
        
        let totalFieldsAllowed = wordFields.count > 4 ? 4: wordFields.count
        let selectedFields = wordFields[randomPick:totalFieldsAllowed]
        
        let stack = UIStackView(arrangedSubviews: selectedFields)
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        
        return stack
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
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
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
    
    required init(with tweet:Tweet) {
        selectedTweet = tweet
        super.init(nibName: nil, bundle: nil)
        
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
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        
    }

    //MARK: Action Functions
    @objc func submitForm() {
        var uncompletedFields:[UIView] = []

        do{
            
            //TODO - perform form validation check
            
            uncompletedFields = form.subviews.filter(){
                field in
                if let roundField = field as? RoundedTextField, roundField.text != ""{
                    return false
                }else{
                    return true
                }
            }
            
            if uncompletedFields.count > 0{
                throw LibControllerError.incompleteForm
            }
            
            let display = DisplayTweetController(for: self.selectedTweet)
            navigationController?.pushViewController(display, animated: false)

        }catch {
            if let libError = error as? LibControllerError, let roundedFields = uncompletedFields as? [RoundedTextField]{

                view.addSubview(self.notification)
                self.notification.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                self.notification.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
                self.notification.label.text = libError.message

                DispatchQueue.main.asyncAfter(deadline: .now()+3){
                    self.notification.removeFromSuperview()
                }
                //TODO - get all fields in view
                for field in roundedFields {
                    field.layer.borderColor =  field.text != "" ? UIColor.white.cgColor : UIColor.red.cgColor
                }

            }
        }
    }
    
//    private func generateForm(){
//       /*
//
//         self.attributedPlaceholder = NSAttributedString(
//         string:placeholder,
//         attributes:[NSAttributedStringKey.foregroundColor:UIColor.fontLight]
//         )
//
//         let field = RoundedTextField(placeholder:placeholderText)
//         field.widthAnchor.constraint(equalToConstant:300).isActive = true
//         return field
// */
//        guard let wordArray = self.selectedTweet?.wordArray else {
//            return
//        }
//
//        var fieldedWords: [Word] = []
//
//        for var word in wordArray {
//            if let tag = word.tag {
//
//
//                word.alternateTextField = field
//
//            }
//            fieldedWords.append(word)
//        }
//
//        let totalFieldsAllowed = fieldedWords.count > 4 ? 4: fieldedWords.count
//        fields = fieldedWords[randomPick:totalFieldsAllowed]
//
//        let form = UIStackView(arrangedSubviews: fields)
//        form.spacing = 30
//        form.translatesAutoresizingMaskIntoConstraints = false
//        form.axis = .vertical
//        form.alignment = .center
//
//        return form
//    }
}

