import Foundation

protocol HomeViewModeling {
    var tweet: Tweet? { get }

    func findTweetDidTap(with urlString: String, completion: @escaping (Bool) -> Void)
}

final class HomeViewModel: HomeViewModeling {
    private let service: TwitterService

    var tweet: Tweet?
    private var tweetID = ""
    private var isTweetID = false

    init(service: TwitterService = TwitterService()) {
        self.service = service
    }

    func findTweetDidTap(
        with urlString: String,
        completion: @escaping (Bool) -> Void
    ) {
        // Extract tweet id from url string
        tweetID = extractTweetID(withURL: urlString)
        guard !tweetID.isEmpty else {
            completion(false)
            return
        }
        isTweetID = true

        // Use tweet id to fetch tweet
        service.fetchTweet(
            params: ["id": tweetID]
        ) { [weak self] tweet in
            self?.tweet = tweet
            self?.isTweetID = false
            completion(true)
        }
    }

    private func extractTweetID(withURL urlString: String) -> String {
        var tweetIdValue = ""
        if let lastForwardSlash = urlString.range(of: "status/", options: .backwards) {
            let idValue = String(urlString.suffix(from: lastForwardSlash.upperBound))
            if idValue.contains("?s=20") {
                let subIdValue = idValue.dropLast(5)
                tweetIdValue = String(subIdValue)
            } else {
                tweetIdValue = idValue
            }
        }
        return tweetIdValue
    }
}
