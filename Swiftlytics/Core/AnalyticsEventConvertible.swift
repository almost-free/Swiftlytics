//
//  AnalyticsEventConvertible.swift
//  FirebaseCore
//
//  Created by Jonathan Willis on 8/5/18.
//

import Foundation

public enum AnalyticsEventConvertibleError: ErrorRef {
    case analyticsEventValueTypeIsNotString
}

public protocol AnalyticsEventConvertible {
    var name: String { get }
    func properties() throws -> [String: String]?
}

public extension AnalyticsEventConvertible {
    // this provides a default implementation that generates properties from the fields of
    // a structure or class that conforms to AnalyticsEventConvertible
    // if there are none, it will return nil
    // if a value cannot be converted into a string, it will throw
    // AnalyticsEventConvertibleError.analyticsEventValueTypeIsNotString
    func properties() throws -> [String: String]? {

        let mirror = Mirror(reflecting: self)

        let properties: [String: String] = try mirror.children
            .compactMap { label, value -> (label: String, value: String?)? in

                func castToOptional<T>(_ any: Any) -> T {
                    return any as! T
                }

                let optionalValue: String? = castToOptional(value)
                guard let notNilLabel = label, optionalValue != nil else {
                    return nil
                }

                guard let stringValue = value as? String ?? (value as? CustomStringConvertible)?.description else {
                        throw AnalyticsEventConvertibleError.analyticsEventValueTypeIsNotString
                }

                return (label: notNilLabel, value: stringValue)
            }
            .filter { $0.label != "name" && $0.label != "properties" }
            .reduce(into: [:] as [String: String]) { (result, next) in
                result[next.label] = next.value
        }

        return properties.isEmpty ? nil : properties
    }
}
