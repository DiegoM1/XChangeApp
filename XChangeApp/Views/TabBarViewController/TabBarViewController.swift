//
//  TabBarViewController.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/21/22.
//

import UIKit
import SwiftUI

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBar.tintColor = .systemGreen
        setupViewControllers()
        // Do any additional setup after loading the view.
    }
    
    func setupViewControllers() {
        viewControllers = [
            createTabBarViewControllers(for: ExchangeViewController(viewModel: ExchangeViewModel()), title: "Exchange", image: UIImage(systemName: "globe") ?? UIImage() ),
            createTabBarViewControllers(for: CryptoExchangeViewController(viewModel: CryptoExchangeViewModel()), title: "CryptoExchange", image: UIImage(systemName: "c.circle.fill") ?? UIImage() ),
            createTabBarViewControllers(for: UIHostingController(rootView: SettingsSwiftUIView()), title: "Settings", image: UIImage(systemName: "gearshape") ?? UIImage())
        ]
    }
    
    
    func createTabBarViewControllers(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
