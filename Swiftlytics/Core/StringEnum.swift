//
//  AnalyticsEnum.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 5/30/18.
//  Copyright © 2018 Almost Free. All rights reserved.
//

import Foundation

public protocol StringEnum: RawRepresentable, CustomStringConvertible where RawValue == String {}

public extension StringEnum {
    public var description: String {
        return rawValue
    }
}
