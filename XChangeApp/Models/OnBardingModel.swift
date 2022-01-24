//
//  OnBardingModel.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/20/22.
//

import Foundation
import UIKit

struct OnBoardingDataModel {
    var title: String
    var imageName: String
    var description: String
    var lastViewController = false
    var image: UIImage {
        return UIImage(named: self.imageName) ?? UIImage()
    }
}
