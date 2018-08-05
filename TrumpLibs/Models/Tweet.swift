//
//  Tweet.swift
//  TrumpLibs
//
//  Created by Justin on 7/20/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import Foundation

struct Tweet{
//    struct Entity: Decodable {
//
//        let user_mentions:[UserMentions]
//
//        struct UserMentions: Decodable{
//            let id:Int
//            let indices:[Int]
//            let name:String
//            let screen_name:String
//        }
//    }
    
    let id:Int
    let createdAt:Date
    let text:String
    let username:String = "@realDonaldTrump"
    let userId:Int
//    var entities:Entity?
    var url:String{
        return "https://twitter.com/statuses/\(self.id)"
    }
    var userUrl:String{
        return "https://twitter.com/\(self.username)"
    }
    let retweetCount:Int
    let favoriteCount:Int
    var wordArray: [Word]?
}

extension Tweet{
        init(from service: TweetService) {
            self.createdAt = service.created_at
            self.id = service.id
            self.userId = service.user.id
            self.favoriteCount = service.favorite_count
            self.retweetCount = service.retweet_count
            self.text = service.text

            self.wordArray = []
        }
}

//extension TweetStore:Decodable{
//    struct TweetKey: CodingKey {
//        var stringValue: String
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//        }
//
//        var intValue: Int? { return nil }
//        init?(intValue: Int) { return nil }
//
//        static let id = TweetKey(stringValue: "id")!
//        static let createdAt = TweetKey(stringValue: "created_at")!
//        static let favoriteCount = TweetKey(stringValue: "favorite_count")!
//        static let retweetCount = TweetKey(stringValue: "retweet_count")!
//        static let text = TweetKey(stringValue: "text")!
//        static let entities = TweetKey(stringValue: "entities")!
//        static let user = TweetKey(stringValue:"user")!
//    }
//
//    public init (from decoder:Decoder) throws {
//        var tweets = [Tweet]()
//        let container = try decoder.container(keyedBy: TweetKey.self)
//        for key in container.allKeys{
//            let tweetContainer = try container.nestedContainer(keyedBy: TweetKey.self, forKey: key)
//            let id = try tweetContainer.decode(Int.self,forKey:key)
//            let
//        }
//    }
//}


//extension GroceryStore: Decodable {
//    public init(from decoder: Decoder) throws {
//        var products = [Product]()
//        let container = try decoder.container(keyedBy: ProductKey.self)
//        for key in container.allKeys {
//            // Note how the `key` in the loop above is used immediately to access a nested container.
//            let productContainer = try container.nestedContainer(keyedBy: ProductKey.self, forKey: key)
//            let points = try productContainer.decode(Int.self, forKey: .points)
//            let description = try productContainer.decodeIfPresent(String.self, forKey: .description)
//            
//            // The key is used again here and completes the collapse of the nesting that existed in the JSON representation.
//            let product = Product(name: key.stringValue, points: points, description: description)
//            products.append(product)
//        }
//        
//        self.init(products: products)
//    }
//}

//extension Tweet{
//    init(from service: TweetService) {
//        self.createdAt = service.created_at
//        self.id = service.id
//        self.userId = service.user.id
//        self.favoriteCount = service.favorite_count
//        self.retweetCount = service.retweet_count
//        self.text = service.text
//        self.entities = service.entities
//        self.wordArray = []
//    }
//}



//extension TweetStore:Encodable{
//    struct TweetKey: CodingKey {
//        var stringValue: String
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//        }
//
//        var intValue: Int? { return nil }
//        init?(intValue: Int) { return nil }
//
//        static let points = TweetKey(stringValue: "points")!
//        static let description = TweetKey(stringValue: "description")!
//    }
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: ProductKey.self)
//
//        for product in products {
//            // Any product's `name` can be used as a key name.
//            let nameKey = ProductKey(stringValue: product.name)!
//            var productContainer = container.nestedContainer(keyedBy: ProductKey.self, forKey: nameKey)
//
//            // The rest of the keys use static names defined in `ProductKey`.
//            try productContainer.encode(product.points, forKey: .points)
//            try productContainer.encode(product.description, forKey: .description)
//        }
//    }
//}
//    struct Tweet:Codable{
//        let created_at:Date
//        let favorite_count:Int
//        let id:Int
//        let retweet_count:Int
//        let text:String
//        let entities:Entity
//        let user: Tweet.User
//
//
//
//        struct User:Codable{
//            let id:Int
//        }
//    }
