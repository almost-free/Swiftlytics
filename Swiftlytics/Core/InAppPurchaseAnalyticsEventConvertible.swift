//
//  InAppPurchaseAnalyticsEventConvertible.swift
//  Swiftlytics
//
//  Created by Jonathan Willis on 8/5/18.
//

import Foundation

public protocol InAppPurchaseEventConvertible: AnalyticsEventConvertible {
    var name: String { get }
    var productId: String { get }
    var transactionId: String { get }
    var price: String { get }
    var currency: String { get }
}
