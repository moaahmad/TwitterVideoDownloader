//
//  WebService.swift
//  TwitterVideoDownloader
//
//  Created by Ahmad, Mohammed (UK - London) on 1/10/20.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import Foundation
import TwitterKit

class TwitterWebservice {
    
    let client = TWTRAPIClient()
    let baseUrl = "https://api.twitter.com/1.1/statuses/show.json"
    var clientError : NSError?
    
    func getTweet(params: [String: String], completion: @escaping (Tweet?) -> ()) {
        
        let request = client.urlRequest(withMethod: "GET", urlString: baseUrl, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(String(describing: connectionError))")
            }
            
            if let data = data {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let tweet = try? decoder.decode(Tweet.self, from: data) {
                    completion(tweet)
                } else {
                    fatalError("Error: There was a problem decoding json")
                }
            }
        }
    }
}

