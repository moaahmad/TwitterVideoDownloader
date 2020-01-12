//
//  DownloadedViewController.swift
//  TwitterVideoDownloader
//
//  Created by Ahmad, Mohammed (UK - London) on 1/7/20.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit
import Photos

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.imageView?.image?.withTintColor(.darkGray)
        }
    }
    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.image = UIImage()
        }
    }
    @IBOutlet weak var userNameLabel: UILabel! {
        didSet {
            userNameLabel.text = ""
        }
    }
    @IBOutlet weak var tweetDateLabel: UILabel! {
        didSet {
            tweetDateLabel.text = ""
        }
    }
    @IBOutlet weak var screenNameLabel: UILabel! {
        didSet {
            screenNameLabel.text = ""
        }
    }
    @IBOutlet weak var tweetTextLabel: UILabel! {
        didSet {
            tweetTextLabel.text = ""
        }
    }
    @IBOutlet weak var contentPreviewImage: UIImageView! {
        didSet {
            contentPreviewImage.image = UIImage()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    let twetMediaCellIdentifier = "TweetMediaCell"
    var tweetVM: TweetViewModel?
    var tweetDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let date: String = dateFormatter.string(from: tweetVM?.createdAt ?? Date())
        return date
    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        if let tweetVM = tweetVM {
            configureDetails(tweetViewModel: tweetVM)
        } else {
            fatalError("Error: Data is not being passed correctly")
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configureDetails(tweetViewModel: TweetViewModel) {
        guard let profileUrl = URL(string: (tweetVM?.profileImage)!) else { return }
        self.profileImage.load(url: profileUrl)
        self.userNameLabel.text = tweetVM?.userName
        self.tweetDateLabel.text = tweetDate
        self.screenNameLabel.text = "@\(tweetVM?.userScreenName ?? "N/A")"
        self.tweetTextLabel.text = tweetVM?.text ?? "N/A"
        guard let previewUrl = URL(string: (tweetVM?.mediaPreviewUrl)!) else { return }
        self.contentPreviewImage.load(url: previewUrl)
    }
}

extension TweetDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tweetVM?.variants?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: twetMediaCellIdentifier, for: indexPath) as? TweetMediaTableViewCell else {
            fatalError("TweetMediaTableViewCell not found")
        }
        
        let videoVariants = self.tweetVM?.variants![indexPath.row]
        cell.mediaTypeLabel.text = "Type: \(videoVariants?.contentType ?? "Unknown")"
        cell.bitrateLabel.text = "Bitrate: \(videoVariants?.bitrate ?? 0)"
        cell.indexPathRow = indexPath.row
        cell.videoUrl = videoVariants?.url
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Media Type: \(tweetVM?.mediaType ?? "Unknown")"
    }
}


