import Foundation
import TwitterKit

final class TwitterService {
    static private let baseUrl = "https://api.twitter.com/1.1/statuses/show.json"

    private let client: TWTRAPIClient

    private var clientError : NSError?

    init(client: TWTRAPIClient = TWTRAPIClient()) {
        self.client = client
    }
    
    func fetchTweet(
        params: [String: String],
        completion: @escaping (Tweet?) -> ()
    ) {
        let request = client.urlRequest(
            withMethod: "GET",
            urlString: Self.baseUrl,
            parameters: params,
            error: &clientError
        )
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(String(describing: connectionError))")
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let tweet = try? decoder.decode(Tweet.self, from: data) {
                    completion(tweet)
                } else {
                    fatalError("Error: There was a problem decoding json")
                }
            }
        }
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
