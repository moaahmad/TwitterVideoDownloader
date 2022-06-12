import UIKit
import TwitterKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        TWTRTwitter.sharedInstance()
            .start(
                withConsumerKey: "opqeEZeOltdMgwbg2i6MLtz7p",
                consumerSecret: "sVrf6BuIjz27JnPjlhp5aBmnqLGpWUkCEgbCWEvC0eBSxp1qwx"
            )
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
}

