//
//  MultiAnalyticsProvider.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 8/5/18.
//

import Foundation

public class MultiAnalyticsProvider: AnalyticsProvider {

    private let providers: [AnalyticsProvider]

    public init(providers: [AnalyticsProvider]) {
        self.providers = providers
    }

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        // Return value will be true if all providers return true

        return providers.reduce(true, { result, provider -> Bool in
            return result && provider.application(application, didFinishLaunchingWithOptions: launchOptions)
        })
    }

    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        // Return value will be true if any provider returns true

        return providers.reduce(false, { (result, provider) -> Bool in
            return result || provider.application(application, open: url, options: options)
        })
    }

    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // Return value will be true if any provider returns true

        return providers.reduce(false, { (result, provider) -> Bool in
            return result || provider.application(application, continue: userActivity, restorationHandler: restorationHandler)
        })
    }

    public func setUserProperty(name propertyName: String, withValue value: Any) {
        providers.forEach { $0.setUserProperty(name: propertyName, withValue: value) }
    }

    public func trackEvent(_ event: AnalyticsEventConvertible) {
        providers.forEach { $0.trackEvent(event) }
    }

    public func setUserId(_ id: String) {
        providers.forEach { $0.setUserId(id) }
    }
    
    public func resetUser() {
        providers.forEach { $0.resetUser() }
    }
    
    public func trackScreen(name: String) {
        providers.forEach { $0.trackScreen(name: name) }
    }
    
    public func trackError(_ error: Error) {
        providers.forEach { $0.trackError(error) }
    }
    
    public func trackError(_ error: NSError) {
        providers.forEach { $0.trackError(error) }
    }
}
