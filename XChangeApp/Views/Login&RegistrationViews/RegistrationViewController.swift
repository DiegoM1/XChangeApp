//
//  RegistrationViewController.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/21/22.
//

import UIKit

class RegistrationViewController: UIViewController, LoadableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordOneTextField: UITextField!
    @IBOutlet weak var repeatPasswordTwoTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    static var identifier: String {
        return String(describing: RegistrationViewController.self)
    }
    
    var viewModel: RegistrationViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        nameTextField.setupDefaultStyle()
        emailTextField.setupDefaultStyle()
        emailTextField.keyboardType = .emailAddress
        passwordTextField.setupDefaultStyle(isSecurityTextEntry: true)
        repeatPasswordOneTextField.setupDefaultStyle(isSecurityTextEntry: true)
        repeatPasswordTwoTextField.setupDefaultStyle(isSecurityTextEntry: true)
        signUpButton.setupDefaultStyle(withTitle: "Sign Up", backgroundColor: .systemGreen, andTintColor: .white, andBorderColor: .systemGreen)
    }

    @IBAction func signUpButton(_ sender: Any) {
        let alertMessage: String? = viewModel.userDataVerification(data: RegistrationDataModel(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text, repeatPaswordOne: repeatPasswordOneTextField.text, repeatPasswordTwo: repeatPasswordTwoTextField.text))
        if  let message = alertMessage {
            showAlert(title: "Wrong Sign Up", message: message )
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField {
            let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return alphabet
        }
        else {
            return true
        }
    }
}
