//
//  MainViewController.swift
//  TwitterVideoDownloader
//
//  Created by Ahmad, Mohammed (UK - London) on 1/7/20.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var enterUrlTextField: UITextField!
    @IBOutlet weak var getTweetButton: UIButton!
    @IBOutlet weak var clearUrlButton: UIButton!
    
    private var tweetVM: TweetViewModel!
    private let tweetDetailSegue = "tweetDetailSegue"
    private var tweetID = ""
    
    @IBAction func didTapClearUrlButton(_ sender: Any) {
    }
    
    @IBAction func didTapGetContentButton(_ sender: UIButton) {
        guard let userUrl = self.enterUrlTextField.text else { return }
        tweetID = userUrl.extractTweetID
        loadTweet(Id: tweetID) {
            if self.tweetVM.isQuoteStatus! {
                print("This is a quote reply")
            } else {
                self.performSegue(withIdentifier: self.tweetDetailSegue, sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTweetButton.layer.cornerRadius = 12
        clearUrlButton.isHidden = true
        if enterUrlTextField.hasText {
            clearUrlButton.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tweetDetailSegue" {
            let tweetDetailVC = segue.destination as! TweetDetailViewController
            tweetDetailVC.tweetVM = self.tweetVM
        }
    }
    
    private func loadTweet(Id: String, completion: @escaping () -> ()) {
        Webservice().getTweet(params: ["id": tweetID]) { tweet in
            if let tweet = tweet {
                self.tweetVM = TweetViewModel(tweet)
                completion()
            }
        }
    }
}
