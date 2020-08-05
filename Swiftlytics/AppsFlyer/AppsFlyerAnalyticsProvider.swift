//
//  AppsFlyerAnalyticsProvider.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 5/31/18.
//  Copyright © 2018 Almost Free. All rights reserved.
//

import Foundation
import AppsFlyerLib

public class AppsFlyerAnalyticsProvider: AnalyticsProvider {
    
    public let priority: Int
    private let devKey: String!
    private let appId: String!

    public init(priority: Int, devKey: String, appId: String) {
        self.priority = priority
        self.devKey = devKey
        self.appId = appId
        AppsFlyerTracker.shared().customData = [:]
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        AppsFlyerTracker.shared().appsFlyerDevKey = devKey
        AppsFlyerTracker.shared().appleAppID = appId
        AppsFlyerTracker.shared().useUninstallSandbox = SwiftlyticsBuildConfiguration.isDebug
        AppsFlyerTracker.shared().useReceiptValidationSandbox = SwiftlyticsBuildConfiguration.isDebug
        AppsFlyerTracker.shared().isDebug = SwiftlyticsBuildConfiguration.isDebug

        AppsFlyerTracker.shared().trackAppLaunch()
        
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerTracker.shared().handleOpen(url, options: options)
        return false
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // see: https://support.appsflyer.com/hc/en-us/articles/207032066-AppsFlyer-SDK-Integration-iOS#5-tracking-deep-linking
        return AppsFlyerTracker.shared().continue(userActivity, restorationHandler: nil)
    }
    
    public func setUserId(_ id: String) {
        AppsFlyerTracker.shared().customerUserID = id;
    }

    public func setUserProperty(name propertyName: String, withValue value: Any){
        AppsFlyerTracker.shared().customData![propertyName] = value
    }

    public func trackEvent(_ event: AnalyticsEventConvertible) {
        AppsFlyerTracker.shared().trackEvent(event.name, withValues: try! event.properties())
    }
    
    public func trackScreen(name: String) {
        AppsFlyerTracker.shared().trackEvent("Screen View", withValues: ["page": name])
    }
}
