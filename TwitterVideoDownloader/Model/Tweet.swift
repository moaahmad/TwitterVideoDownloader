//
//  Tweet.swift
//  TwitterVideoDownloader
//
//  Created by Ahmad, Mohammed (UK - London) on 1/10/20.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    var createdAt: String?
    var id: Int?
    var text: String?
    var extendedEntities: MediaResponse?
    var user: UserDetails?
    var isQuoteStatus: Bool?
}

struct MediaResponse: Decodable {
    var media: [Media]?
}

struct Media: Decodable {
    var mediaUrlHttps: String?
    var type: String?
    var videoInfo: VideoVariantResponse?
}

struct VideoVariantResponse: Decodable {
    var variants: [Variants]?
}

struct Variants: Decodable {
    var bitrate: Int?
    var contentType: String?
    var url: String?
}

struct UserDetails: Decodable {
    var id: Int?
    var name: String?
    var screenName: String?
    var profileImageUrlHttps: String?
}
