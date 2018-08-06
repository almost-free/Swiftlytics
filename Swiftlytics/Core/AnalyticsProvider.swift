import Foundation

public protocol AnalyticsProvider: class {
    // UIApplicationDelegate methods
    var priority: Int { get }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    
    // application(_:sourceApplication:annotation:) has been deprecated in iOS 9.0+ and replaced with:
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    
    // Custom analytics methods
    
    func setUserId(_ id: String)

    func setUserProperty(name propertyName: String, withValue value: Any)
    
    func trackEvent(_ event: AnalyticsEventConvertible)
}
