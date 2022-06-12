import UIKit

final class TweetDetailViewController: UIViewController {
    // MARK: - IBOutlets

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

    // MARK: - Properties

    var viewModel: DetailViewModeling?

    // MARK: - View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else { return }
        configureDetails(viewModel: viewModel)
        profileImage.makeImageCircular()
        configureTableView()
    }

    // MARK: - IBActions

    @IBAction func didTapDoneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Private Functions

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configureDetails(viewModel: DetailViewModeling) {
        guard let profileURL = URL(string: (viewModel.profileImage)) else { return }
        self.profileImage.load(url: profileURL)
        self.userNameLabel.text = viewModel.userName
        self.tweetDateLabel.text = viewModel.tweetDate
        self.screenNameLabel.text = viewModel.userScreenName
        self.tweetTextLabel.text = viewModel.text

        if let previewURL = URL(string: (viewModel.mediaPreviewUrl)) {
            self.contentPreviewImage.load(url: previewURL)
        }
    }
}

extension TweetDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel?.mediaVariants.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TweetMediaTableViewCell.identifier,
            for: indexPath
        ) as? TweetMediaTableViewCell else {
            fatalError("TweetMediaTableViewCell not found")
        }
        let videoVariants = self.viewModel?.mediaVariants[indexPath.row]
        cell.mediaTypeLabel.text = videoVariants?.contentType ?? "Unknown"
        let convertedBitrate = (videoVariants?.bitrate)! / 1000
        cell.bitrateLabel.text = "\(convertedBitrate) kbps"
        cell.updateCell(indexPathRow: 0, videoURL: videoVariants?.url)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TweetMediaTableViewCell.identifier,
            for: indexPath
        ) as? TweetMediaTableViewCell else {
            fatalError("TweetMediaTableViewCell not found")
        }
        cell.updateCell(
            indexPathRow: indexPath.row,
            videoURL: viewModel?.variants[indexPath.row].url
        )
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        viewModel?.mediaType == "Unknown media type" ?
        "" : "Media Type: \(viewModel?.mediaType ?? "Unknown")"
    }
}


