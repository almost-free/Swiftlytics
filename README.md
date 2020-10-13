# Swiftlytics

[![CI Status](https://img.shields.io/travis/jondwillis/Swiftlytics.svg?style=flat)](https://travis-ci.org/jondwillis/Swiftlytics)
[![Version](https://img.shields.io/cocoapods/v/Swiftlytics.svg?style=flat)](https://cocoapods.org/pods/Swiftlytics)
[![License](https://img.shields.io/cocoapods/l/Swiftlytics.svg?style=flat)](https://cocoapods.org/pods/Swiftlytics)
[![Platform](https://img.shields.io/cocoapods/p/Swiftlytics.svg?style=flat)](https://cocoapods.org/pods/Swiftlytics)

## Getting started

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Declare a (global) instance of MultiAnalyticsProvider

```swift
import Swiftlytics

let swiftlytics: AnalyticsProvider = MultiAnalyticsProvider(providers: [
    FirebaseAnalyticsProvider(), //requires GoogleServices.info
    FacebookAnalyticsProvider(),
    AppsFlyerAnalyticsProvider(devKey: "YOUR_DEV_KEY", appId: "YOUR_APP_ID")
])
```

### Pass AppDelegate lifecycle events to your instance

See [Example/Swiftlytics/AppDelegate.swift](Example/Swiftlytics/AppDelegate.swift)

### Define your event

```swift
struct MemoryWarningEvent: AnalyticsEventConvertible {
    let name = "memory_warning"
    let count: UInt
}
```

### Track your event

```swift

...

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

    count += 1
    swiftlytics.trackEvent(MemoryWarningEvent(count: count))
}
```

### Track user properties to qualify events

```swift
swiftlytics.setUserId(UUID().uuidString) // your persistent database value in production
swiftlytics.setUserProperty(name: "name", withValue: "Sandy")
```

## Requirements

Tested on Xcode 9.4.1, Swift 4, Cocoapods 1.5.3

## Installation

Swiftlytics is available through [CocoaPods](https://cocoapods.org), and is split into subspecs to avoid bloat from providers that you do not wish to integrate. To install
it, simply add the following line to your Podfile:

```ruby
pod 'Swiftlytics'
pod 'Swiftlytics/Firebase'
pod 'Swiftlytics/AppsFlyer'
pod 'Swiftlytics/Facebook'
```

## Contributing- adding a new provider

### Add an entry to Swiftlytics.podspec

```ruby
s.subspec 'AppsFlyer' do |appsflyer|
    appsflyer.source_files = 'Swiftlytics/AppsFlyer/**/*'
    appsflyer.dependency 'AppsFlyerFramework'
end
```

### Define a new AnalyticsProvider, implementing all protocol methods

See [Swiftlytics/AppsFlyer/AppsFlyerAnalyticsProvider](Swiftlytics/AppsFlyer/AppsFlyerAnalyticsProvider) for an example

### Add any tests to the Example project

Be sure to import the subspec in Example/Podfile, e.g.:

```ruby
pod 'Swiftlytics/Facebook', :path => '../'
```

and then `pod install`

## License

Swiftlytics is available under the MIT license. See the LICENSE file for more info.
