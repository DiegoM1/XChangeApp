//
//  PageViewModel.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/20/22.
//

import Foundation
import UIKit

protocol PageViewModelProtocol {
    func getPageViewControllersCount() -> Int
    func getCurrentPageViewController(WithIndex index: Int) -> OnBoardingPageViewController
    func index(of: UIViewController) -> Int
    func viewDidLoad()
}

class PageViewModel: PageViewModelProtocol {
    
    let onBoardingDataModelArray = [
        OnBoardingDataModel(title: "Friendly app", imageName: "easyIcon", description: "Extremely simple to use"),
        OnBoardingDataModel(title: "Be always updated", imageName: "exchangeIcon", description: "Latest exchange rate for any FIAT or Cryptocurrency"),
        OnBoardingDataModel(title: "Make your own way", imageName: "customIcon", description: "Easily customizable for your own needs", lastViewController: true)
    ]
    
    var pageIndex = 0
    
    var pageViewControllersArray: [OnBoardingPageViewController] = [OnBoardingPageViewController]()
    
    
    func viewDidLoad() {
        createPageViewControllers()
    }
    
    private func createPageViewControllers () {
        for item in onBoardingDataModelArray {
            if let onBoardingVC = OnBoardingPageViewController.instantiate() as? OnBoardingPageViewController {
                let _ = onBoardingVC.view
                onBoardingVC.setupView(model: item)
                pageViewControllersArray.append(onBoardingVC)
            }
        }
    }
    
    func getPageViewControllersCount() -> Int {
        return pageViewControllersArray.count
    }
    
    func getCurrentPageViewController(WithIndex index: Int) -> OnBoardingPageViewController {
        print(pageIndex)
        return pageViewControllersArray[index]
    }
    
    func index(of viewController: UIViewController) -> Int {
        return pageViewControllersArray.firstIndex(of: viewController as! OnBoardingPageViewController) ?? 0
    }
}

