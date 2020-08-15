//
//  AppCenterAnalyticsProvider.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 08/15/20.
//  Copyright © 2018 Almost Free. All rights reserved.
//

import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

extension Set where Element == AppCenterAnalyticsProvider.Service {
    func convert() -> [AnyClass] {
        map { $0.service }
    }
}

public class AppCenterAnalyticsProvider: AnalyticsProvider {
    
    public let priority: Int
    private let appCenterId: String
    private let services: Set<Service>

    private(set) var properties = MSCustomProperties()
    
    public enum Service {
        case analytics, crashes
        
        var service: AnyClass! {
            switch self {
            case .analytics:
                return MSAnalytics.self
            default:
                return MSCrashes.self
            }
        }
    }

    public init(priority: Int, appCenterId: String, services: Set<Service>) {
        self.priority = priority
        self.appCenterId = appCenterId
        self.services = services
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        MSAppCenter.start(appCenterId, withServices: services.convert())
        
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return false
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // see: https://support.appsflyer.com/hc/en-us/articles/207032066-AppsFlyer-SDK-Integration-iOS#5-tracking-deep-linking
        return false
    }
    
    public func setUserId(_ id: String) {
        MSAppCenter.setUserId(id)
    }

    public func setUserProperty(name propertyName: String, withValue value: Any) {
        
        if let value = value as? Bool {
            properties.setBool(value, forKey: propertyName)
        } else if let value = value as? String {
            properties.setString(value, forKey: propertyName)
        } else if let value = value as? Date {
            properties.setDate(value, forKey: propertyName)
        } else if let value = value as? NSNumber {
            properties.setNumber(value, forKey: propertyName)
        }
        
        MSAppCenter.setCustomProperties(properties)
    }

    public func trackEvent(_ event: AnalyticsEventConvertible) {
        if services.contains(.analytics) {
            MSAnalytics.trackEvent(event.name, withProperties: try! event.properties())
        }
    }
    
    public func trackScreen(name: String) {
        if services.contains(.analytics) {
            MSAnalytics.trackEvent(name)
        }
    }
    
    public func trackError(_ error: Error) {
        if services.contains(.crashes) {
            // no-op
        }
    }
    
    public func trackError(_ error: NSError) {
        if services.contains(.crashes) {
            // no-op
        }
    }
}
