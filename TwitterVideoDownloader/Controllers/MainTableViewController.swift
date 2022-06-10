//
//  MainViewController.swift
//  TwitterVideoDownloader
//
//  Created by Ahmad, Mohammed (UK - London) on 1/7/20.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit

final class MainTableViewController: UITableViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var pasteButton: UIBarButtonItem!
    @IBOutlet weak var enterUrlTextField: UITextField!
    @IBOutlet weak var findItButton: UIButton! {
        didSet {
            findItButton.layer.cornerRadius = 12
            findItButton.layer.borderWidth = 1
            findItButton.layer.borderColor = UIColor.systemOrange.cgColor
        }
    }

    // MARK: - Properties

    private static let tweetDetailSegue = "tweetDetailSegue"
    private let mediaProvider: MediaProvider
    private let pasteBoard = UIPasteboard.general
    private var tweetID = ""
    private var isTweetID = false

    // MARK: - Initializers

    init(mediaProvider: MediaProvider = MediaProvider()) {
        self.mediaProvider = mediaProvider
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        dismissKeyboardOnTap()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.tweetDetailSegue {
            guard let tweetDetailVC = segue.destination as? TweetDetailViewController else { return }
            tweetDetailVC.tweetVM = mediaProvider.tweetVM
        }
    }

    // MARK: - IBActions

    @IBAction private func didTapPasteButton(_ sender: Any) {
        if let pasteString = pasteBoard.string {
            enterUrlTextField.text = pasteString
        } else {
            presentAlert(message: "Copy a Tweet link first", cancel: "Say less")
        }
    }

    @IBAction private func didTapFindItButton(_ sender: UIButton) {
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

    // MARK: - Private Functions

    private func fetchMediaFromSource() {
        mediaProvider.fetchTweet(with: tweetID) {
            self.performSegue(withIdentifier: Self.tweetDetailSegue, sender: nil)
            self.isTweetID = false
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
