import Foundation

protocol DetailViewModeling {
    var mediaVariants: [Variants] { get }
    var tweetDate: String { get }
    var text: String { get }
    var userScreenName: String { get }
    var userName: String { get }
    var profileImage: String { get }
    var mediaPreviewUrl: String { get }
    var variants: [Variants] { get }
    var mediaType: String { get }
}

final class DetailViewModel: DetailViewModeling {
    private let tweet: Tweet

    init(_ tweet: Tweet) {
        self.tweet = tweet
    }

    var mediaVariants: [Variants] {
        guard let variants = tweetMedia?.videoInfo?.variants else {
            return []
        }
        let filteredVariants = variants.filter {
            $0.contentType == "video/mp4"
        }
        return filteredVariants.sorted { $0.bitrate! < $1.bitrate! }
    }

    var tweetDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm - MMM dd, YYYY"
        let date = dateFormatter.string(from: createdAt)
        return "Posted at \(date)"
    }
    
    var id: Int {
        tweet.id ?? 0
    }
    
    var text: String {
        tweet.text ?? "No text"
    }
    
    var mediaPreviewUrl: String {
        tweetMedia?.mediaUrlHttps ?? "No media preview url"
    }
    
    var mediaType: String {
        tweetMedia?.type ?? "Unknown media type"
    }
    
    var variants: [Variants] {
        tweetMedia?.videoInfo?.variants ?? []
    }
    
    var userId: Int {
        tweet.user?.id ?? 0
    }

    var userName: String {
        tweet.user?.name ?? "No user name"
    }

    var userScreenName: String {
        let username = tweet.user?.screenName ?? "No user screen name"
        return "@\(username)"
    }
    
    var profileImage: String {
        tweet.user?.profileImageUrlHttps ?? "No profile image"
    }

    private var createdAt: Date {
        let date = DateConverter.toDate(dateString: self.tweet.createdAt!, format: .ddMMM)
        return date ?? Date()
    }

    private var tweetMedia: Media? {
        guard let tweetMedia = tweet.extendedEntities?.media?.first else {
            return tweet.quotedStatus?.extendedEntities.media?.first
        }
        return tweetMedia
    }
}
