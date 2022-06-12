import UIKit

final class HomeViewController: UITableViewController {
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
    private let viewModel: HomeViewModeling
    private let pasteBoard = UIPasteboard.general

    // MARK: - Initializers

    init(viewModel: HomeViewModeling = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        self.viewModel = HomeViewModel()
        super.init(coder: coder)
    }

    // MARK: - View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        dismissKeyboardOnTap()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.tweetDetailSegue {
            guard let tweetDetailVC = segue.destination as? TweetDetailViewController,
                  let tweet = viewModel.tweet else {
                      return
                  }
            tweetDetailVC.viewModel = DetailViewModel(tweet)
        }
    }

    // MARK: - IBActions

    @IBAction private func didTapPasteButton(_ sender: Any) {
        if let pasteString = pasteBoard.string {
            enterUrlTextField.text = pasteString
        } else {
            presentAlert()
        }
    }

    @IBAction private func didTapFindItButton(_ sender: UIButton) {
        guard let urlString = self.enterUrlTextField.text,
              !self.enterUrlTextField.text!.isEmpty else {
                  presentAlert()
                  return
              }

        viewModel.findTweetDidTap(
            with: urlString
        ) { [weak self] success in
            if success {
                self?.performSegue(
                    withIdentifier: Self.tweetDetailSegue,
                    sender: nil
                )
            } else {
                self?.presentAlert()
            }
        }
    }

    // MARK: - Private Functions
    
    private func presentAlert(
        message: String = "Please paste in a Tweet link",
        cancel: String = "Say less"
    ) {
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
