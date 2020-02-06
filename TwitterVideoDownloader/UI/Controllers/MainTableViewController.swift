//
//  MainViewController.swift
//  TwitterVideoDownloader
//
//  Created by Ahmad, Mohammed (UK - London) on 1/7/20.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit

enum MediaSource {
    case twitter
    case instagram
    case youtube
}

class MainTableViewController: UITableViewController {
    
    @IBOutlet weak var pasteButton: UIBarButtonItem!
    @IBOutlet weak var sourceSegmentedControl: UISegmentedControl!
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
    private var selectedMediaSource = MediaSource.twitter
    private var isTweetID = false
    let mediaProvider = MediaProvider()
    
    @IBAction func didTapPasteButton(_ sender: Any) {
        if let pasteString = pasteBoard.string {
            enterUrlTextField.text = pasteString
        } else {
            presentAlert(message: "Copy a Tweet link first", cancel: "Say less")
        }
    }
    
    @IBAction func mediaSourceChanged(_ sender: Any) {
        switch sourceSegmentedControl.selectedSegmentIndex {
        case 0:
            selectedMediaSource = MediaSource.twitter
        case 1:
            selectedMediaSource = MediaSource.instagram
        case 2:
            selectedMediaSource = MediaSource.youtube
        default:
            break
        }
    }
    
    @IBAction func didTapFindItButton(_ sender: UIButton) {
        guard let enteredURL = self.enterUrlTextField.text,
            !self.enterUrlTextField.text!.isEmpty else {
                return presentAlert(message: "Please paste in a Tweet link",
                                    cancel: "Say less")
        }
        tweetID = mediaProvider.extractMediaID(withURL: enteredURL)
        
        guard !tweetID.isEmpty else {
            return presentAlert(message: "Please paste in a Tweet link",
                                cancel: "Say less")
        }
        isTweetID = true
        fetchMediaFromSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        dismissKeyboardOnTap()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == tweetDetailSegue {
            let tweetDetailVC = segue.destination as! TweetDetailViewController
            tweetDetailVC.tweetVM = mediaProvider.tweetVM
        }
    }

    private func fetchMediaFromSource() {
        switch selectedMediaSource {
        case .twitter:
            mediaProvider.fetchTweet(with: tweetID) {
                self.performSegue(withIdentifier: self.tweetDetailSegue, sender: nil)
                self.isTweetID = false
            }
        case .instagram:
            print("downloading instagram video")
        case .youtube:
            print("downloading youtube video")
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
