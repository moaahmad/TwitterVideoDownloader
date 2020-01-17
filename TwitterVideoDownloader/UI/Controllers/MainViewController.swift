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
            getTweetButton.layer.borderColor = UIColor.systemOrange.cgColor
        }
    }
    
    var tweetVM: TweetViewModel!
    private let tweetDetailSegue = "tweetDetailSegue"
    private var tweetID = ""
    private var isTweetID = false
    private let pasteBoard = UIPasteboard.general
    
    @IBAction func didTapPasteButton(_ sender: Any) {
        if let pasteString = pasteBoard.string {
            enterUrlTextField.text = pasteString
        } else {
            presentAlert(message: "Copy a Tweet link first", cancel: "Say less")
        }
    }
    
    @IBAction func didTapGetContentButton(_ sender: UIButton) {
        guard let userURL = self.enterUrlTextField.text,
            !self.enterUrlTextField.text!.isEmpty else {
                return presentAlert(message: "Please paste in a Tweet link",
                                    cancel: "Say less")
        }
        tweetID = userURL.extractTweetID
        
        guard !tweetID.isEmpty else {
            return presentAlert(message: "Please paste in a Tweet link",
                                cancel: "Say less")
        }
        isTweetID = true
        loadTweet(with: tweetID) {
            self.performSegue(withIdentifier: self.tweetDetailSegue, sender: nil)
            self.isTweetID = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        dismissKeyboardOnTap()
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
    
    private func dismissKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func presentAlert(message: String, cancel: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: cancel, style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
}
