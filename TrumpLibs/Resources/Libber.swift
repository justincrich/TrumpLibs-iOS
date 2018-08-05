//
//  Libber.swift
//  TrumpLibs
//
//  Created by Justin on 7/20/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import Foundation


class Libber:NSLinguisticTagger{
    
    private enum LibberErr: Error{
        case noMinResults
        
        var message: String{
            switch self{
            case .noMinResults:
                return "Tweet has insufficent parts of speach"
            }
        }
    }
    
    private let excludedWords = ["and","http","https","the","are","that","of","in","from","out","now"]
    
    init(){
        super.init(tagSchemes: [.tokenType,.nameTypeOrLexicalClass,.language,.nameType], options: 0)

    }
    
//    func randomOptions(for text:String, total count:Int) throws -> [LibberOptions]{
//        let pos = partsOfSpeech(for: text)
//
//        if pos.count < count {
//            throw LibberErr.noMinResults
//        }
//
//
//
//    }
    
    func randomTweet(from tweets:[Tweet]) -> (Int, Tweet) {
        let selectedIndex = Int(arc4random_uniform(UInt32(tweets.count)))
        let selectedTweet = tweets[selectedIndex]
        return (selectedIndex,partsOfSpeech(for: selectedTweet))
    }
    
    // MARK: - Mad Lib Functions
    func partsOfSpeech(for tweet:Tweet) -> Tweet {
        self.string = tweet.text
        
        let options: NSLinguisticTagger.Options = [.joinNames]
        let range = NSRange(location:0, length:tweet.text.utf16.count)
        let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName, .noun, .idiom, .verb]
        var tweetWordArray: [Word] = []
       
        self.enumerateTags(in: range, unit: .word, scheme: .nameTypeOrLexicalClass, options: options) { tag, tokenRange, _ in

            let wordText = (tweet.text as NSString).substring(with: tokenRange)

            var word = Word( text: wordText, alternateTextField: nil, tag: nil, resultIndex: tweetWordArray.count)
            
            if let tag = tag, tags.contains(tag), !excludedWords.contains(wordText.lowercased()),wordText.count > 4{
                word.tag = tag
                word.alternateTextField = RoundedTextField(formatPlaceholder(word.tag?.rawValue ?? ""))
            }
            
            tweetWordArray.append(word)
        }
        var outputTweet = tweet
        
        outputTweet.wordArray = tweetWordArray
        return outputTweet
    }
    
    private func formatPlaceholder(_ unformattedText: String)->String{
        switch(unformattedText){
        case "PersonalName":
            return "Person"
        case "PlaceName":
            return "Place"
        default:
            return unformattedText
        }
    }
    
}
