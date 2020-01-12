//
//  TweetMediaTableViewCell.swift
//  TwitterVideoDownloader
//
//  Created by Mo Ahmad on 11/01/2020.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit
import Photos

class TweetMediaTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaTypeLabel: UILabel!
    @IBOutlet weak var bitrateLabel: UILabel!
    @IBOutlet weak var previewButton: UIButton!
    
    var tweetVM: TweetViewModel!
    var indexPathRow: Int!
    var videoUrl: String!
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        print("Save button was tapped")
        downloadVideo(at: indexPathRow, with: videoUrl)
    }
    
    private func downloadVideo(at index: Int, with videoUrl: String) {
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: videoUrl), let urlData = NSData(contentsOf: url) {
             let galleryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[index];
             let filePath="\(galleryPath)/tempFile.mp4"
            
            DispatchQueue.main.async {
                urlData.write(toFile: filePath, atomically: true)
                   PHPhotoLibrary.shared().performChanges({
                   PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL:
                   URL(fileURLWithPath: filePath))
                }) {
                   success, error in
                   if success {
                      print("Succesfully Saved")
                   } else {
                      print(error?.localizedDescription)
                   }
                }
             }
          }
       }
    }
}
