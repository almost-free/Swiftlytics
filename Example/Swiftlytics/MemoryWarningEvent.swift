//
//  MemoryWarningEvent.swift
//  Swiftlytics_Example
//
//  Created by Jonathan Willis on 8/5/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Swiftlytics

struct MemoryWarningEvent: AnalyticsEventConvertible {
    let name = "memory_warning"
    let count: UInt
}
