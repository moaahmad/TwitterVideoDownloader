//
//  TweetMediaTableViewCell.swift
//  TwitterVideoDownloader
//
//  Created by Mo Ahmad on 11/01/2020.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit
import Photos

final class TweetMediaTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet weak var mediaTypeLabel: UILabel!
    @IBOutlet weak var bitrateLabel: UILabel!
    @IBOutlet weak var saveButtonImage: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(didTapSaveButton)
            )
            self.addGestureRecognizer(tap)
        }
    }

    // MARK: - IBOutlets

    private var indexPathRow = 0
    private var videoURL = ""
    private var hasDownloaded = false

    private lazy var generator = UINotificationFeedbackGenerator()

    // MARK: - IBOutlets

    @objc func didTapSaveButton() {
        guard let view = superview else { return }
        LoaderHelper.showLoadingView(view: view)
        saveVideo(at: indexPathRow, with: videoURL) {
            self.hasDownloaded = true
        }
    }

    // MARK: - Functions

    func updateCell(indexPathRow: Int, videoURL: String?) {
        self.indexPathRow = indexPathRow
        self.videoURL = videoURL ?? ""
    }
}

// MARK: - Private Functions

private extension TweetMediaTableViewCell {
    func saveVideo(
        at index: Int,
        with videoUrl: String,
        completion: @escaping () -> Void
    ) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let url = URL(string: videoUrl),
                  let urlData = NSData(contentsOf: url) else {
                      return
                  }

            let galleryPath = NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask,
                true
            ),
                filePath = "\(galleryPath[index])/tempFile.mp4"

            self?.downloadVideo(with: urlData, at: filePath)
        }
    }

    func downloadVideo(with urlData: NSData, at filePath: String) {
        DispatchQueue.main.async {
            urlData.write(toFile: filePath, atomically: true)

            PHPhotoLibrary.shared()
                .performChanges({
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(
                    atFileURL: URL(
                        fileURLWithPath: filePath
                    )
                )}
            ) { success, error in
                if success {
                    self.generator.notificationOccurred(.success)
                    self.hasDownloaded = true
                    LoaderHelper.dismissLoadingView()
                } else {
                    self.generator.notificationOccurred(.error)
                }
            }
        }
    }
}
