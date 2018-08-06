//
//  FacebookAnalyticsProvider.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 5/30/18.
//  Copyright © 2018 Almost Free. All rights reserved.
//

import Foundation
import FacebookCore

private extension Dictionary where Iterator.Element == (key: String, value: String) {
    func toAppEventParametersDictionary() -> AppEvent.ParametersDictionary {
        return reduce(into: [:] as AppEvent.ParametersDictionary) { (result, entry) in
            result[.custom(entry.key)] = entry.value
        }
    }
}

public class FacebookAnalyticsProvider: AnalyticsProvider {

    
    public let priority: Int
    
    public init(priority: Int) {
        self.priority = priority
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        AppEventsLogger.activate(application)
        
        return true
    }
    
    public func application(_ application: UIApplication,
                            open url: URL,
                            options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        SDKApplicationDelegate.shared.application(application, open: url, options: options)
        
        return false
    }

    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return false
    }

    
    public func setUserId(_ id: String) {
        AppEventsLogger.userId = id
    }

    public func setUserProperty(name propertyName: String, withValue value: Any) {
        // No-op
    }

    public func trackEvent(_ event: AnalyticsEventConvertible) {
        let parameters = try! event.properties()?.toAppEventParametersDictionary() ?? [:]
        let event = AppEvent(name: event.name, parameters: parameters)
        
        AppEventsLogger.log(event)
    }
}
