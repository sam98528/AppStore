//
//  ViewController.swift
//  AppStore
//
//  Created by Sam.Lee on 4/15/24.
//

import UIKit

class TodayViewController: UIViewController, Configurable {
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(withTitle: "투데이")
    }
    
}
