//
//  LoadableController.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/20/22.
//

import Foundation
import UIKit

protocol LoadableViewController {
    static var identifier: String { get }
}

extension LoadableViewController where Self: UIViewController {
    static func instantiate() -> UIViewController {
        // Create a reference to the the appropriate storyboard
        let storyboard = UIStoryboard(name: identifier, bundle: .main)
        guard let customViewController = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("\(self.identifier) can't be instantiated")
        }
        return customViewController
    }
}
