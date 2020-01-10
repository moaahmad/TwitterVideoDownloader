//
//  MainViewController.swift
//  TwitterVideoDownloader
//
//  Created by Ahmad, Mohammed (UK - London) on 1/7/20.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit
import TwitterKit

class MainViewController: UIViewController {
    
    var statusUrl: String = ""
    var id: Int!
    var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.twitter.com/1.1/statuses/show.json?id=1214359414863319040")!
        
        //        Webservice().getTweet(url: url) { tweet in
        //
        //            if let tweet = tweet {
        //                self.id = tweet.id
        //                self.text = tweet.text
        //            }
        //        }
        
        
        let client = TWTRAPIClient()
        let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/show.json"
        let params = ["id": "1214359414863319040"]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", urlString: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            //                let json = try JSONSerialization.jsonObject(with: data!, options: [])
            //                print("json: \(json)")
            
            if let data = data {
                
                if let tweet = try? JSONDecoder().decode(Tweet.self, from: data) {
                    print(tweet)
                }
            }
        }
    }
}
