//
//  Tweet.swift
//  TrumpLibs
//
//  Created by Justin on 7/20/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import Foundation

struct Tweet{
    let id:Int
    let createdAt:Date
    let text:String
    let username:String
    let entities: Dictionary <String,Any>?
    let userId:Int
    var url:String{
        return "https://twitter.com/statuses/\(self.id)"
    }
    var userUrl:String{
        return "https://twitter.com/\(self.username)"
    }
    let retweetCount:Int?
    let favoriteCount:Int?
    var textPartsOfSpeech: [LibberOption]?
    var textWordsArray: [String]?
    var textUserInput: [String]?
    
}
