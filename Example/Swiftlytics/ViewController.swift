//
//  ViewController.swift
//  Swiftlytics
//
//  Created by Jon Willis on 08/05/2018.
//  Copyright (c) 2018 Jon Willis. All rights reserved.
//

import UIKit
import Swiftlytics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        swiftlytics.setUserId(UUID().uuidString) // your persistent database value in production
        swiftlytics.setUserProperty(name: "name", withValue: "Sandy")
    }

    private var count: UInt = 0

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        count += 1
        swiftlytics.trackEvent(MemoryWarningEvent(count: count))
    }
}

