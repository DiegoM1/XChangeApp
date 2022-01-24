//
//  ChangeCryptoExchangeViewController.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/23/22.
//

import UIKit

class ChangeCryptoExchangeViewController: UIViewController, LoadableViewController, UITextFieldDelegate {
    static var identifier: String {
        return String(describing: ChangeCryptoExchangeViewController.self)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cryptoObtainedLabel: UILabel!
    @IBOutlet weak var mainCurrency: UILabel!
    @IBOutlet weak var amounTextField: UITextField!
    
    @IBOutlet weak var cryptoIdLabel: UILabel!
    
    var pairExchange = 0.0
    var cryptoExchange = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        cryptoObtainedLabel.text = "0.0"
        amounTextField.delegate = self
        mainCurrency.text = "Main currency: \(XChangeUserDefaultManager.shared.getUserDefaultCurrency())"
        
        // Do any additional setup after loading the view.
    }
    
    func setupView(data: ExchangeCellDataModel) {
        
        CryptoAPIDataManager().fetchCryptoData(withId: data.title, completion: { value in
                self.cryptoExchange = value.asset.price
                DispatchQueue.main.async {
                    if value.asset.description == "" {
                        self.descriptionLabel.isHidden = true
                    } else {
                    self.descriptionLabel.text = value.asset.description
                    }
                }
            })
        
        ExchangeAPIDataManager().getPairExchangeApiData(currencySelected: "USD") { double in
            self.pairExchange = double
        }
        titleLabel.text = data.title
        priceLabel.text = String(format: "%.2f" ,data.exchange) + " $"
        cryptoIdLabel.text = data.title
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
            if  let text = textField.text, text.count > 0, let doubleText = Double(text) {
                
            let newValue = doubleText * pairExchange
            print(pairExchange, newValue)
                cryptoObtainedLabel.text = String(format: "%.5f",newValue / cryptoExchange)
            } else {
                cryptoObtainedLabel.text = "0.0"
            }
        }
    }
