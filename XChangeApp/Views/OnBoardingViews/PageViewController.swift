//
//  PageViewController.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/20/22.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, LoadableViewController {
    static var identifier: String = String(describing: PageViewController.self)
    
     var viewModel: PageViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        self.didMove(toParent: self)
        self.view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        viewModel?.viewDidLoad()
        self.setViewControllers([viewModel.getCurrentPageViewController(WithIndex: 0)], direction: .forward, animated: false)
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
         let viewControllerIndex = viewModel.index(of: viewController)
               let previousIndex = viewControllerIndex - 1
               guard previousIndex >= 0 else {
                   return nil
               }
       
        return viewModel.getCurrentPageViewController(WithIndex: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let viewControllerIndex = viewModel.index(of: viewController)
                let nextIndex = viewControllerIndex + 1
                guard nextIndex < viewModel.getPageViewControllersCount() else {
                    return nil
                }
        return viewModel.getCurrentPageViewController(WithIndex: nextIndex)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewModel.getPageViewControllersCount()
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
