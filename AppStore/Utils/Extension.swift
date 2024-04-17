//
//  File.swift
//  AppStore
//
//  Created by Sam.Lee on 4/15/24.
//

import Foundation
import UIKit
import SnapKit


extension  UINavigationController {
    
    func setupNavBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.label]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.label]
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
    }
}
