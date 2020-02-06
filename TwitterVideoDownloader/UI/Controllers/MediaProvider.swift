//
//  MediaProvider.swift
//  TwitterVideoDownloader
//
//  Created by Mo Ahmad on 28/01/2020.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import Foundation

final class MediaProvider {
    
    // provide one interface for fetching media
    enum MediaSource {
        case twitter
        case youtube
        case instagram
    }
    
    func fetchMedia(withURLString urlString: String, completion: @escaping () -> Void) { //Will return a model object
        let urlType = checkURLType(urlString: urlString)
        switch urlType {
        case .twitter:
            //twitterService.getMediaObject
            break
        case .youtube:
            //youtubeService.getMediaObject
            break
        case .instagram:
            break
        }
    }
    
    //check url for media provider i.e youtube, twitter etc
    
    func checkURLType(urlString: String) -> MediaSource{
        //check string and return source
//        if urlString.baseURL "twitter.com"
        
        return .youtube
    }
    
    
    
    //get media object
    
    
    // extract media url
    
    // download media
    
}
