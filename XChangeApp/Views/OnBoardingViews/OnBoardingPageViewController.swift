//
//  FirstOnBoardingPageViewController.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/20/22.
//

import UIKit

class OnBoardingPageViewController: UIViewController, LoadableViewController {
    
    @IBOutlet weak var goToLoginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    static let identifier = String(describing: OnBoardingPageViewController.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)

        self.view.layer.insertSublayer(gradient, at: 0)
        goToLoginButton.layer.cornerRadius = 8
    }
    
    
    func setupView(model: OnBoardingDataModel) {
        titleLabel.text = model.title
        iconImage.image = model.image
        descriptionLabel.text = model.description
        goToLoginButton.isHidden = true
        if model.lastViewController {
            goToLoginButton.isHidden = false
        }
    }

    @IBAction func goToLoginAction(_ sender: Any) {
        
        let loginVC = LoginViewController.instantiate() as! LoginViewController
        loginVC.viewModel = LoginViewModel()
        let navigation = UINavigationController(rootViewController: loginVC)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .crossDissolve
        present(navigation, animated: true)
    }
    
}
