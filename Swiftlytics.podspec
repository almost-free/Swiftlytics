#
# Be sure to run `pod lib lint Swiftlytics.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Swiftlytics'
  s.version          = '0.5.2'
  s.summary          = 'Swiftlytics is a lightweight analytics abstraction for many arbitrary analytics providers'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Swiftlytics is a simple protocol-oriented analytics abstraction that affords easy integration and disintegration with various analytics providers.
                       DESC

  s.homepage         = 'https://github.com/almost-free/Swiftlytics'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jon Willis' => 'jon@almostfree.tech' }
  s.source           = { :git => 'https://github.com/almost-free/Swiftlytics.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/almostfreetech'

  s.ios.deployment_target = '9.0'

  s.static_framework = true

  s.swift_version = '5.1'

  s.subspec 'Core' do |core|
    core.source_files = 'Swiftlytics/Core/**/*'
  end

  s.subspec 'Firebase' do |firebase|
      firebase.source_files = 'Swiftlytics/Firebase/**/*'
      firebase.dependency 'Firebase/Core'
      firebase.dependency 'Firebase/Analytics'
      firebase.dependency 'Swiftlytics/Core'
  end
  
  s.subspec 'FirebaseCrashlytics' do |firebase|
      firebase.source_files = 'Swiftlytics/FirebaseCrashlytics/**/*'
      firebase.dependency 'Firebase/Core'
      firebase.dependency 'Firebase/Crashlytics'
      firebase.dependency 'Swiftlytics/Core'
  end

  s.subspec 'Facebook' do |facebook|
      facebook.source_files = 'Swiftlytics/Facebook/**/*'
      facebook.dependency 'FacebookCore'
      facebook.dependency 'Swiftlytics/Core'
  end
  
  s.subspec 'AppCenter' do |appsflyer|
      appsflyer.source_files = 'Swiftlytics/AppCenter/**/*'
      appsflyer.dependency 'AppCenter'
      appsflyer.dependency 'Swiftlytics/Core'
  end
  
  s.subspec 'AppsFlyer' do |appsflyer|
      appsflyer.source_files = 'Swiftlytics/AppsFlyer/**/*'
      appsflyer.dependency 'AppsFlyerFramework'
      appsflyer.dependency 'Swiftlytics/Core'
  end
  
  s.subspec 'Mixpanel' do |appsflyer|
      appsflyer.source_files = 'Swiftlytics/Mixpanel/**/*'
      appsflyer.dependency 'Mixpanel'
      appsflyer.dependency 'Swiftlytics/Core'
  end
  
end
