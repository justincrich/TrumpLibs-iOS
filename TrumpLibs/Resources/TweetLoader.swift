//
//  TweetLoader.swift
//  TrumpLibs
//
//  Created by Justin on 7/20/18.
//  Copyright © 2018 Justin. All rights reserved.
//

import Foundation
//import Firebase
import PromiseKit


struct TweetService:Decodable{
    struct User:Decodable{
        let id:Int
    }
    let created_at:Date
    let favorite_count:Int
    let id:Int
    let retweet_count:Int
    let text:String
    let user: User
}
extension DateFormatter {
    static let twitterFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

enum TweetType:String{
    case bro,classic,presidential
}

class TweetLoader{
    

    
    enum TweetLoaderError:Error{
        case NoData
    }
    
    private enum TweetLoaderErrors: Error{
        case localFileMissing
        case parseError
        case emptyResult
        case criticalTransformError
        case dateParseError
        
        var message: String {
            switch self {
            case .emptyResult:
                return "No tweets found"
            case .localFileMissing:
                return "data.json file does not exist"
            case .parseError:
                return "could not parse file"
            case .criticalTransformError:
                return "could not unwrap tweet id/text/date"
            case .dateParseError:
                return "could not parse date"
            }
        }
    }
    
    init(){
//        database = Database.database().reference().child("tweets")
    }
    
    func retrieveTweets(of type:TweetType) -> Promise<Any>{

        return Promise {
            seal in
            print(type.rawValue)
            let firebaseEndpoint = "https://trump-libs.firebaseio.com/tweets/\(type.rawValue).json"
            guard let url = URL(string: firebaseEndpoint) else {
                print("Error: cannot create URL")
                return
            }
            let urlRequest = URLRequest(url: url)
            let session = URLSession.shared

            let task = session.dataTask(with: urlRequest) { data, response, error in
                do{
                    let decoder = JSONDecoder()
                    guard let data = data else{
                        throw TweetLoaderError.NoData
                    }
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.twitterFormat)
                    let serviceTweets = try decoder.decode([String:TweetService].self, from: data).values
                    let tweets:[Tweet] = serviceTweets.map{
                        service in
                        return Tweet(from: service)
                    }
                    seal.fulfill(tweets)
                }catch{
                    seal.reject(error)
                }
            }
            task.resume()
//            self.database.child(type).observe(.childAdded, with:{
//                snapshot in
//                if let snapshots = snapshot.children.allObjects as? [DataSnapshot]{
//                    for snap in snapshots {
//                        print(snap.value(forKey: "id"))
//                    }
//                }
//                //seal.fulfill(snapshot.value)
//            })
        }
//        return Promise<Any>{
//            fulfill, reject in
////            self.database.child(type).observe(.childAdded, with:{
////                snapshot in
////                print(snapshot)
////            })
//            //        do{
//            //
//            //
//            //            if let tweets = tweets {
//            //                for (key,value) in tweets {
//            //
//            //                    do{
//            //                        let tweet = try transformTweet(from: value as! Dictionary<String,AnyObject>)
//            //                        tweetOutput.append(tweet)
//            //                    }catch{
//            //                        let typeError = error as! TweetLoaderErrors
//            //
//            //                        print("Tweet transform error: tweet \(key) \(typeError.message)")
//            //                    }
//            //
//            //                }
//            //            }
//            //
//            //        }catch{
//            //            let typeError = error as! TweetLoaderErrors
//            //
//            //            print("Tweet retrieval error: \(typeError.message)")
//            //        }
//            fulfill(Array())
//        }
    }

   
    
    private func readLocally() throws -> Dictionary <String,AnyObject>? {
        var dataOutput: [String:AnyObject] = [:]
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            throw TweetLoaderErrors.localFileMissing
        }
        
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let parsedResult = jsonResult as? Dictionary<String,AnyObject>{
                dataOutput = parsedResult
            }else{
                throw TweetLoaderErrors.emptyResult
            }
        }catch{
            throw TweetLoaderErrors.parseError
        }
        return dataOutput
    }
    
}


//struct TweetDictionaryService:Decodable{
//    struct TweetKey: CodingKey {
//        var stringValue: String
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//        }
//        var intValue: Int? { return nil }
//        init?(intValue: Int) { return nil }
//    }
//    public init(from decoder: Decoder) throws {
//        var tweets = [TweetService]()
//        let container = try decoder.container(keyedBy: TweetKey.self)
//        decoder.unkeyedContainer()
//        for key in container.allKeys {
//            let tweetContainer = try container.nestedContainer(keyedBy: TweetKey.self, forKey: key)
//
//
//            // The key is used again here and completes the collapse of the nesting that existed in the JSON representation.
//            let product = TweetService(name: key.stringValue, points: points, description: description)
//            products.append(product)
//        }
//
//        self.init(products: products)
//    }
//    var tweets: [TweetService]
//}


//enum TweetLocation{
//    case local
//    case remote
//}

//    private func transformTweet(from tweetSource:Dictionary<String,AnyObject>) throws -> Tweet {
//
//        guard let id = tweetSource["id"] as? Int,
//            let stringDate = tweetSource["created_at"] as? String,
//            let text = tweetSource["text"] as? String
//            else{
//                throw TweetLoaderErrors.criticalTransformError
//            }
//
//
//        let handle = Bundle.main.object(forInfoDictionaryKey: "tweetURL") as! String
//
//        let entities = tweetSource["entities"] as? [String : Any]
//
//        let user  = tweetSource["user"] as? [String:Any] ?? [:]
//        let userId = user["id"] as? Int ?? -1
//
//        let retweetCount = tweetSource["retweet_count"] as? Int
//        let favoriteCount = tweetSource["favorite_count"] as? Int
//
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
//
//        guard let dateCreated = dateFormatter.date(from: stringDate ) else {
//            throw TweetLoaderErrors.dateParseError
//        }
//
//        return Tweet(id: id, createdAt: dateCreated, text: text, userId: userId, retweetCount: retweetCount, favoriteCount: favoriteCount, wordArray: nil)
//
//
//
//
//    }
