//
//  TweetViewModel.swift
//  TwitterVideoDownloader
//
//  Created by Mo Ahmad on 10/01/2020.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import Foundation

struct TweetViewModel {
    private let tweet: Tweet
}

extension TweetViewModel {
    init(_ tweet: Tweet) {
        self.tweet = tweet
    }
}

extension TweetViewModel {
    var createdAt: Date {
        
        let date = DateConverter.toDate(dateString: self.tweet.createdAt!, format: .ddMMM)
        return date ?? Date()
    }
    
    var id: Int? {
        return self.tweet.id
    }
    
    var text: String? {
        return self.tweet.text
    }
    
    var mediaPreviewUrl: String? {
        return self.tweet.extendedEntities?.media![0].mediaUrlHttps
    }
    
    var mediaType: String? {
        return self.tweet.extendedEntities?.media![0].type
    }
    
    var variants: [Variants]? {
        return self.tweet.extendedEntities?.media![0].videoInfo?.variants
    }
    
    var userId: Int? {
        return self.tweet.user?.id
    }

    var userName: String? {
        return self.tweet.user?.name
    }

    var userScreenName: String? {
        return self.tweet.user?.screenName
    }
    
    var profileImage: String? {
        return self.tweet.user?.profileImageUrlHttps
    }
    
    var isQuoteStatus: Bool? {
        return self.tweet.isQuoteStatus
    }
}
