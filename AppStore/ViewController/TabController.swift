//
//  TabController.swift
//  AppStore
//
//  Created by Sam.Lee on 4/16/24.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = .systemBackground
        
    }
    
    private func setupTabs(){
        let today = self.createNav(with: "투데이", and: UIImage(systemName: "doc.text.image"), vc: TodayViewController())
        let game = self.createNav(with: "게임", and: UIImage(systemName: "gamecontroller"), vc: GameViewController())
        let app = self.createNav(with: "앱", and: UIImage(systemName: "square.stack.3d.up.fill"), vc: AppViewController())
        let search = self.createNav(with: "검색", and: UIImage(systemName: "magnifyingglass"), vc: SearchViewController())
        self.setViewControllers([today,game,app,search], animated: true)
        
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        vc.view.backgroundColor = .systemBackground
        
        let nav = UINavigationController(rootViewController: vc)
        nav.setupNavBar()
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title
        nav.navigationBar.prefersLargeTitles = true
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: self, action: nil)
        
        return nav
    }

}
