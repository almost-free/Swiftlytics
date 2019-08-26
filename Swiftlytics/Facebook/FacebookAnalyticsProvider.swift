//
//  FacebookAnalyticsProvider.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 5/30/18.
//  Copyright © 2018 Almost Free. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FacebookCore

private extension Dictionary where Iterator.Element == (key: String, value: String) {
    func toAppEventParametersDictionary() -> [String: Any] {
        return reduce(into: [:] as [String: Any]) { (result, entry) in
            result[entry.key] = entry.value
        }
    }
}

public class FacebookAnalyticsProvider: AnalyticsProvider {

    
    public let priority: Int
    
    public init(priority: Int) {
        self.priority = priority
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        AppEvents.activateApp()
        
        return true
    }
    
    public func application(_ application: UIApplication,
                            open url: URL,
                            options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        ApplicationDelegate.shared.application(application, open: url, options: options)
        
        return false
    }

    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return false
    }

    
    public func setUserId(_ id: String) {
        AppEvents.userID = id
    }

    public func setUserProperty(name propertyName: String, withValue value: Any) {
        // No-op
    }

    public func trackEvent(_ event: AnalyticsEventConvertible) {
        let parameters = try! event.properties()?.toAppEventParametersDictionary() ?? [:]

        AppEvents.logEvent(AppEvents.Name(event.name), parameters: parameters)
    }
}
