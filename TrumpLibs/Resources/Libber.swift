//
//  Libber.swift
//  TrumpLibs
//
//  Created by Justin on 7/20/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import Foundation

struct LibberOption{
    let word:String
    let tag:NSLinguisticTag
    let resultIndex:Int
}

extension Array {
    
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}

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
        
        let options: NSLinguisticTagger.Options = [.joinNames,.omitWhitespace]
        let range = NSRange(location:0, length:tweet.text.utf16.count)
        let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName, .noun, .idiom, .verb]
        var tweetWordArray: [String] = []
        var selectedPartsOfSpeech: [LibberOption] = []
       
        self.enumerateTags(in: range, unit: .word, scheme: .nameTypeOrLexicalClass, options: options) { tag, tokenRange, _ in
            let word = (tweet.text as NSString).substring(with: tokenRange)
            if let tag = tag, tags.contains(tag), word.count > 4{
                
                selectedPartsOfSpeech.append(LibberOption( word: word, tag: tag, resultIndex: tweetWordArray.count))

            }
            tweetWordArray.append(word)
        }
        var outputTweet = tweet
        let fieldsToBePicked = selectedPartsOfSpeech.count > 4 ? 4 : selectedPartsOfSpeech.count
        outputTweet.textPartsOfSpeech = selectedPartsOfSpeech[randomPick:fieldsToBePicked]
        outputTweet.textWordsArray = tweetWordArray
        return outputTweet
    }
    
    func tokenizeText(for text:String){
        
    }
    
}
