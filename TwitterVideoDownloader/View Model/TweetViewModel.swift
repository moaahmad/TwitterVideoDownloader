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
    
    var id: Int {
        return self.tweet.id ?? 0
    }
    
    var text: String {
        return self.tweet.text ?? "No text"
    }
    
    var mediaPreviewUrl: String {
        return self.tweet.extendedEntities?.media?[0].mediaUrlHttps ?? "No media preview url"
    }
    
    var mediaType: String {
        return self.tweet.extendedEntities?.media?[0].type ?? "Unknown media type"
    }
    
    var variants: [Variants] {
        return self.tweet.extendedEntities?.media![0].videoInfo?.variants ?? []
    }
    
    var userId: Int {
        return self.tweet.user?.id ?? 0
    }

    var userName: String {
        return self.tweet.user?.name ?? "No user name"
    }

    var userScreenName: String {
        return self.tweet.user?.screenName ?? "No user screen name"
    }
    
    var profileImage: String {
        return self.tweet.user?.profileImageUrlHttps ?? "No profile image"
    }
    
    var isQuoteStatus: Bool {
        return self.tweet.isQuoteStatus ?? false
    }
}
