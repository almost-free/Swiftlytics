//
//  FirebaseCrashlyticsAnalyticsProvider.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 8/16/20.
//

import FirebaseCore
import FirebaseCrashlytics

struct NSErrorWrapper: Error {
    let nsError: NSError
    var localizedDescription: String {
        nsError.localizedDescription
    }
}

public class FirebaseCrashlyticsAnalyticsProvider: AnalyticsProvider {
    
    public let priority: Int
    
    public init(priority: Int) {
        self.priority = priority
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return false
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return false
    }
    
    public func setUserId(_ id: String) {
        Crashlytics.crashlytics().setUserID(id)
    }

    public func setUserProperty(name propertyName: String, withValue value: Any) {
        Crashlytics.crashlytics().setCustomValue(value, forKey: propertyName)
    }
    
    public func trackEvent(_ event: AnalyticsEventConvertible) {
        Crashlytics.crashlytics().log("Event: \(event.name)")
    }
    
    public func trackScreen(name: String) {
        Crashlytics.crashlytics().log("Screen View \(name)")
    }
    
    public func trackError(_ error: Error) {
        Crashlytics.crashlytics().record(error: error)
    }
    
    public func trackError(_ error: NSError) {
        Crashlytics.crashlytics().record(error: NSErrorWrapper(nsError: error))
    }
}
