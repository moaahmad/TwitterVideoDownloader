//
//  MediaProvider.swift
//  TwitterVideoDownloader
//
//  Created by Mo Ahmad on 28/01/2020.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import Foundation

final class MediaProvider {
    
    var tweetVM: TweetViewModel? = nil
        
//    func fetchMedia(withURLString urlString: String, completion: @escaping () -> Void) { //Will return a model object
//        switch MediaSource.self {
//        case .twitter:
//            //twitterService.getMediaObject
//            break
//        case .youtube:
//            //youtubeService.getMediaObject
//            
//            break
//        case .instagram:
//            break
//        }
//    }
    
    //check url for media provider i.e youtube, twitter etc

//    func checkURLType(urlString: String) -> MediaSource{
//        //check string and return source
////        if urlString.baseURL "twitter.com"
//
//        return .youtube
//    }
    
    func fetchTweet(with Id: String, completion: @escaping () -> ()) {
        TwitterWebservice().getTweet(params: ["id": Id]) { tweet in
            if let tweet = tweet {
                self.tweetVM = TweetViewModel(tweet)
                completion()
            }
        }
    }
    
    //TODO: Refactor to be source agnostic, right now it only uses Twitter
    
    func extractMediaID(withURL urlString: String) -> String {
        
        var tweetIdValue = ""
        if let lastForwardSlash = urlString.range(of: "status/", options: .backwards) {
            let IdValue = String(urlString.suffix(from: lastForwardSlash.upperBound))
            if IdValue.contains("?s=20") {
                let subIdValue = IdValue.dropLast(5)
                tweetIdValue = String(subIdValue)
            } else {
                tweetIdValue = IdValue
            }
        }
        return tweetIdValue
    }
    
    
    //get media object
    
    
    // extract media url
    
    // download media
    
}
