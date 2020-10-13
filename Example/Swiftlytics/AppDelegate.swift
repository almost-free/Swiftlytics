//
//  AppDelegate.swift
//  Swiftlytics
//
//  Created by Jon Willis on 08/05/2018.
//  Copyright (c) 2018 Jon Willis. All rights reserved.
//

import UIKit
import Swiftlytics

let swiftlytics: AnalyticsProvider = MultiAnalyticsProvider(providers: [
    FirebaseAnalyticsProvider(), //requires GoogleServices.info
    FirebaseCrashlyticsAnalyticsProvider(), //requires GoogleServices.info
    FacebookAnalyticsProvider(),
    AppsFlyerAnalyticsProvider(devKey: "YOUR_DEV_KEY", appId: "YOUR_APP_ID"),
    MixpanelAnalyticsProvider(mixpanelToken: "YOUR_TOKEN"),
])

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // IMPORTANT: This line must be called before any view controller is initialized.
        // Services are initialized here that are being used by the rest of the app.
        let result = swiftlytics.application(application, didFinishLaunchingWithOptions: launchOptions)

        // Override point for customization after application launch.

        return result
    }

    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return swiftlytics.application(application,
                                       open: url,
                                       options: options)
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return swiftlytics.application(application,
                                       continue: userActivity,
                                       restorationHandler: restorationHandler as! ([Any]?) -> Void)
    }
}

