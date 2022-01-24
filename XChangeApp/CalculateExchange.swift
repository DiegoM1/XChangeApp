//
//  CalculateExchange.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/23/22.
//

import Foundation


class CalculateExchange {
    
    static func calculateCurrencyExchange(WithTextNumber number: Double, ToCurrency userExchangeSelected: String, completion: @escaping (String) -> ()) {
        ExchangeAPIDataManager().getPairExchangeApiData(currencySelected: userExchangeSelected) { exchangeRate in
            let newValue = number * exchangeRate
            completion(String(format: "%.2f",newValue))
        }
    }
    
    static func calculateCryptoExchange(WithTextNumber number: Double, cryptoExchange: Double, completion: @escaping (String) -> ()) {
        ExchangeAPIDataManager().getPairExchangeApiData(currencySelected: "USD") { result in
            let newValue = number * result
               completion(String(format: "%.5f",newValue / cryptoExchange))
        }
    }
}
