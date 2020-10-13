//
//  AppsFlyerAnalyticsProvider.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 8/15/20.
//

import AppsFlyerLib

public class AppsFlyerAnalyticsProvider: AnalyticsProvider {
    
    private let devKey: String!
    private let appId: String!
    private let tracker: AppsFlyerLib

    public init(devKey: String, appId: String) {
        self.devKey = devKey
        self.appId = appId
        self.tracker = AppsFlyerLib.shared()
        self.tracker.customData = [:]
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        tracker.appsFlyerDevKey = devKey
        tracker.appleAppID = appId
        tracker.useUninstallSandbox = SwiftlyticsBuildConfiguration.isDebug
        tracker.useReceiptValidationSandbox = SwiftlyticsBuildConfiguration.isDebug
        tracker.isDebug = SwiftlyticsBuildConfiguration.isDebug
        
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        tracker.handleOpen(url, options: options)
        return false
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // see: https://support.appsflyer.com/hc/en-us/articles/207032066-AppsFlyer-SDK-Integration-iOS#5-tracking-deep-linking
        return tracker.continue(userActivity, restorationHandler: nil)
    }
    
    public func setUserId(_ id: String) {
        tracker.customerUserID = id
    }
    
    public func resetUser() {
        tracker.customerUserID = nil
        tracker.customData = nil
    }

    public func setUserProperty(name propertyName: String, withValue value: Any){
        tracker.customData![propertyName] = value
    }

    public func trackEvent(_ event: AnalyticsEventConvertible) {
        tracker.logEvent(event.name, withValues: try! event.properties())
    }
    
    public func trackScreen(name: String) {
        tracker.logEvent("Screen View", withValues: ["page": name])
    }
    
    public func trackError(_ error: Error) {
        // no-op
    }
    
    public func trackError(_ error: NSError) {
        // no-op
    }
}

