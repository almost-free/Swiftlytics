//
//  MixpanelAnalyticsProvider.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 8/5/20.
//

import Mixpanel

public class MixpanelAnalyticsProvider: AnalyticsProvider {
    
    private let token: String
    private var mixpanel: Mixpanel!
    
    public init(mixpanelToken: String) {
        self.token = mixpanelToken
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        mixpanel = Mixpanel.sharedInstance(withToken: token, launchOptions: launchOptions)
        mixpanel.enableLogging = SwiftlyticsBuildConfiguration.isDebug
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return false
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return false
    }
    
    public func setUserId(_ id: String) {
        mixpanel.registerSuperProperties(["distinct_id": id])
    }

    public func resetUser() {
        mixpanel.reset()
    }
    
    public func setUserProperty(name propertyName: String, withValue value: Any) {
        if let value = value as? String {
            mixpanel.registerSuperProperties([propertyName: value])
        } else if let value = value as? CustomStringConvertible {
            mixpanel.registerSuperProperties([propertyName: value])
        }
    }
    
    public func trackEvent(_ event: AnalyticsEventConvertible) {
        mixpanel.track(event.name, properties: try! event.properties())
    }
    
    public func trackScreen(name: String) {
        mixpanel.track("Screen View", properties: ["page": name])
    }
    
    public func trackError(_ error: Error) {
        // no-op
    }
    
    public func trackError(_ error: NSError) {
        // no-op
    }
}
