//
//  WebService.swift
//  TwitterVideoDownloader
//
//  Created by Ahmad, Mohammed (UK - London) on 1/10/20.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import Foundation

class Webservice {
   
  func getTweet(url: URL, completion: @escaping (Tweet?) -> ()) {
     
    URLSession.shared.dataTask(with: url) { (data, response, error) in
       
      if let error = error {
         
        print(error.localizedDescription)
        completion(nil)
         
      } else if let data = data {
         
        let tweet = try? JSONDecoder().decode(Tweet.self, from: data)
         
        if let tweet = tweet {
          completion(tweet)
        }
      }
    }.resume()
  }
}
