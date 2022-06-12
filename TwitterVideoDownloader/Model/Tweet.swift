import Foundation

struct Tweet: Decodable {
    var createdAt: String?
    var id: Int?
    var text: String?
    var extendedEntities: MediaResponse?
    var user: UserDetails?
    var isQuoteStatus: Bool?
    var quotedStatus: QuotedStatus?
}

struct MediaResponse: Decodable {
    var media: [Media]?
}

struct Media: Decodable {
    var mediaUrlHttps: String?
    var type: String?
    var videoInfo: VideoVariantResponse?
}

struct VideoVariantResponse: Decodable {
    var variants: [Variants]?
}

struct Variants: Decodable {
    var bitrate: Int?
    var contentType: String?
    var url: String?
}

struct UserDetails: Decodable {
    var id: Int?
    var name: String?
    var screenName: String?
    var profileImageUrlHttps: String?
}

struct QuotedStatus: Decodable {
    var text: String
    var extendedEntities: MediaResponse
}
