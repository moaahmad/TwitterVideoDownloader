//
//  Tweet.swift
//  TwitterVideoDownloader
//
//  Created by Ahmad, Mohammed (UK - London) on 1/10/20.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    var id: Int
    var text: String
//    var user: UserDetails
//    var extendedEntities: Media
    
}

//struct Media {
//    var mediaUrlHttps: String
//    var type: String
//    var videoInfo: Video
//
//}
//
//struct UserDetails {
//    var id: Int
//    var name: String
//    var screenName: String
//}
//
//struct Video {
//    var
//}

//let decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase
