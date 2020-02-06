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
    @IBOutlet weak var findItButton: UIButton! {
        didSet {
            findItButton.layer.cornerRadius = 12
            findItButton.layer.borderWidth = 1
            findItButton.layer.borderColor = UIColor.systemOrange.cgColor
        }
    }
    
    private let tweetDetailSegue = "tweetDetailSegue"
    private let pasteBoard = UIPasteboard.general
    private var tweetID = ""
    private var isTweetID = false
    var tweetVM: TweetViewModel? = nil
    
    @IBAction func didTapPasteButton(_ sender: UIButton) {
        if let pasteString = pasteBoard.string {
            enterUrlTextField.text = pasteString
        } else {
            presentAlert(message: "Copy a Tweet link first", cancel: "Say less")
        }
    }
    
    //TODO: Refactor to be source agnostic, right now it only uses Twitter
    
    @IBAction func didTapFindItButton(_ sender: UIButton) {
        guard let enteredURL = self.enterUrlTextField.text,
            !self.enterUrlTextField.text!.isEmpty else {
                return presentAlert(message: "Please paste in a Tweet link",
                                    cancel: "Say less")
        }
        tweetID = extractMediaID(withURL: enteredURL)
        
        guard !tweetID.isEmpty else {
            return presentAlert(message: "Please paste in a Tweet link",
                                cancel: "Say less")
        }
        isTweetID = true
        fetchTweet(with: tweetID) {
            self.performSegue(withIdentifier: self.tweetDetailSegue, sender: nil)
            self.isTweetID = false
        }
    }
    
    func extractMediaID(withURL urlString: String) -> String {
        
        var tweetIdValue = ""
        if let lastForwardSlash = urlString.range(of: "status/", options: .backwards) {
            let IdValue = String(urlString.suffix(from: lastForwardSlash.upperBound))
            if IdValue.contains("?s=20") {
                let subIdValue = IdValue.dropLast(5)
                tweetIdValue = String(subIdValue)
            } else {
                tweetIdValue = IdValue
            }
        }
        return tweetIdValue
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
    
    private func fetchTweet(with Id: String, completion: @escaping () -> ()) {
        TwitterWebservice().getTweet(params: ["id": tweetID]) { tweet in
            if let tweet = tweet {
                self.tweetVM = TweetViewModel(tweet)
                completion()
            }
        }
    }
    
    private func presentAlert(message: String, cancel: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: cancel, style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func dismissKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}
