//
//  FirebaseAnalyticsProvider.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 5/29/18.
//  Copyright © 2018 Almost Free. All rights reserved.
//

import FirebaseCore
import FirebaseAnalytics

public class FirebaseAnalyticsProvider: AnalyticsProvider {
    
    public let priority: Int
    
    public init(priority: Int) {
        self.priority = priority
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        Analytics.setAnalyticsCollectionEnabled(false)
        FirebaseApp.configure()
        
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        Analytics.handleOpen(url)
        
        return false
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        Analytics.handleUserActivity(userActivity)
        
        return false
    }
    
    public func setUserId(_ id: String) {
        Analytics.setUserID(id)
    }

    public func setUserProperty(name propertyName: String, withValue value: Any) {
        if let value = value as? String {
            Analytics.setUserProperty(value, forName: propertyName)
        } else if let value = value as? CustomStringConvertible {
            Analytics.setUserProperty(value.description, forName: propertyName)
        }
    }
    
    public func trackEvent(_ event: AnalyticsEventConvertible) {
        Analytics.logEvent(event.name, parameters: try! event.properties())
    }
}
