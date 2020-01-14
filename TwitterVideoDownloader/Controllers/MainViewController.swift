//
//  MainViewController.swift
//  TwitterVideoDownloader
//
//  Created by Ahmad, Mohammed (UK - London) on 1/7/20.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var pasteButton: UIBarButtonItem!
    @IBOutlet weak var enterUrlTextField: UITextField!
    @IBOutlet weak var getTweetButton: UIButton! {
        didSet {
            getTweetButton.layer.cornerRadius = 12
            getTweetButton.layer.borderWidth = 1
            getTweetButton.layer.borderColor = UIColor.orange.cgColor
        }
    }
    
    var tweetVM: TweetViewModel!
    private let tweetDetailSegue = "tweetDetailSegue"
    private var tweetID = ""
    private let pasteBoard = UIPasteboard.general

    @IBAction func didTapPasteButton(_ sender: Any) {
        if let pasteString = pasteBoard.string {
            enterUrlTextField.text = pasteString
        } else {
            let alertController = UIAlertController(title: nil, message: "Copy a tweet link first", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Say less", style: .cancel))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapGetContentButton(_ sender: UIButton) {
        guard let userUrl = self.enterUrlTextField.text else { return }
        tweetID = userUrl.extractTweetID
        loadTweet(with: tweetID) {
            self.performSegue(withIdentifier: self.tweetDetailSegue, sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == tweetDetailSegue {
            let tweetDetailVC = segue.destination as! TweetDetailViewController
            tweetDetailVC.tweetVM = self.tweetVM
        }
    }
    
    private func loadTweet(with Id: String, completion: @escaping () -> ()) {
        Webservice().getTweet(params: ["id": tweetID]) { tweet in
            if let tweet = tweet {
                self.tweetVM = TweetViewModel(tweet)
                completion()
            }
        }
    }
}
