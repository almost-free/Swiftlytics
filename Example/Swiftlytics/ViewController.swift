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
    
    struct TestError: Error { }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        swiftlytics.trackScreen(name: String(describing: type(of: self)))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            swiftlytics.trackError(TestError())
        }
    }

    private var count: UInt = 0

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        count += 1
        swiftlytics.trackEvent(MemoryWarningEvent(count: count))
    }
}

