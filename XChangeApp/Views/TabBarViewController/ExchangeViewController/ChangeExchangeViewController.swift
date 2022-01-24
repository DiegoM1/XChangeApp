//
//  ChangeExchangeTableViewController.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/22/22.
//

import UIKit

class ChangeExchangeViewController: UIViewController, LoadableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userExchangeTitle: UILabel!
    @IBOutlet weak var userExchangeImage: UIImageView!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var userExchangeTextField: UITextField!
    @IBOutlet weak var exchangeImage: UIImageView!
    @IBOutlet weak var exchangeTitle: UILabel!
    static var identifier: String {
        return String(describing: ChangeExchangeViewController.self)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        userExchangeTextField.delegate = self
        exchangeLabel.layer.masksToBounds = true
        exchangeLabel.layer.cornerRadius = 5
        userExchangeTextField.keyboardType = .numberPad
        // Do any additional setup after loading the view.
    }
    
    func setupView(withExchangeSelected exchangeSelected: ExchangeCellDataModel, exchangeRate: Double) {
        // Change this logic to view model
        userExchangeTitle.text = XChangeUserDefaultManager.shared.getUserDefaultCurrency()
        //
        exchangeTitle.text = exchangeSelected.title
        userExchangeImage.image = UIImage(named: userExchangeTitle.text!)
        exchangeImage.image =   UIImage(named: exchangeSelected.title)
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == userExchangeTextField {
            if  let text = textField.text, text.count > 0, let doubleText = Double(text) {
                CalculateExchange.calculateCurrencyExchange(WithTextNumber: doubleText, ToCurrency: exchangeTitle.text ?? "", completion: { text in
                    DispatchQueue.main.async {
                        self.exchangeLabel.text = text
                    }
                })
            } else {
                exchangeLabel.text = ""
            }
        }
    }
    
}
