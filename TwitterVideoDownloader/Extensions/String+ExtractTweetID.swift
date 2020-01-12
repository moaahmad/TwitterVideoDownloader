//
//  String+ExtractTweetID.swift
//  TwitterVideoDownloader
//
//  Created by Mo Ahmad on 12/01/2020.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import Foundation

extension String {
    var extractTweetID: String {
        var tweetIdValue = ""
        if let lastForwardSlash = self.range(of: "/", options: .backwards) {
            let IdValue = String(self.suffix(from: lastForwardSlash.upperBound))
            if IdValue.contains("?s=20") {
                let subIdValue = IdValue.dropLast(5)
                tweetIdValue = String(subIdValue)
            } else {
                tweetIdValue = IdValue
            }
        }
        return tweetIdValue
    }
}
