//
//  LoginViewController.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/20/22.
//

import UIKit

class LoginViewController: UIViewController, LoadableViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    static var identifier = String(describing: LoginViewController.self)
    
    
    var viewModel: LoginViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI() {
        emailTextField.setupDefaultStyle(withPlaceholder: "E-mail")
        passwordTextField.setupDefaultStyle(withPlaceholder: "Password", isSecurityTextEntry: true)
        
        loginButton.setupDefaultStyle(withTitle: "Log In", backgroundColor: .systemGreen, andTintColor: .white, andBorderColor: .systemGreen)
        
        signUpButton.setupDefaultStyle(withTitle: "Sign Up", backgroundColor: .white, andTintColor: .black, andBorderColor: .gray)
    }

    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        let alertMessage = viewModel.checkIfUserExist(data: LoginDataModel(email: emailTextField.text, password: passwordTextField.text))
        if let alert = alertMessage {
            showAlert(title: "Log in failed", message: alert)
        } else {
            let tabBarVC = TabBarViewController()
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true)
        }
        
    }
    
    private func showAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let registrationVC = RegistrationViewController.instantiate() as! RegistrationViewController
        registrationVC.viewModel = RegistrationViewModel()
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
}
