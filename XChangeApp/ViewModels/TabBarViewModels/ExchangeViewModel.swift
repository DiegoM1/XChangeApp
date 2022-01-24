//
//  ExchangeViewModel.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/22/22.
//

import Foundation

protocol ExchangeViewControllerProtocol {
    func reloadTableView()
}

protocol ExchangeViewModelProtocol {
    var view: ExchangeViewControllerProtocol? { get set }
    func viewDidLoad()
    func getCountExchange() -> Int
    func getExchangeData(withIndex index: Int) -> ExchangeCellDataModel
    func getCurrentCurrencyText() -> String
    func pullToRefresh()
    func getPairExchangeRate(_ currency: String, completion: @escaping () -> ())
    func getPairExchangeRate() -> Double
}

class ExchangeViewModel: ExchangeViewModelProtocol {
    private var currentCurrency: String? = nil
    var view: ExchangeViewControllerProtocol?
    var pairExchange = 0.0
    private lazy var exchangeAPIManager: ExchangeAPIDataManager = ExchangeAPIDataManager()
    
    private var exchangeDataArray = [ExchangeCellDataModel]()
    func viewDidLoad() {
        if currentCurrency == nil {
            exchangeAPIManager.getExchangeAPIData() { result in
                self.buildExchangeCellModel(data: result)
            }
            
        } else if currentCurrency != XChangeUserDefaultManager.shared.getUserDefaultCurrency() {
            exchangeAPIManager.getExchangeAPIData() { result in
                self.buildExchangeCellModel(data: result)
            }
        }
        currentCurrency = XChangeUserDefaultManager.shared.getUserDefaultCurrency()
    }
    
    func pullToRefresh() {
        exchangeAPIManager.getExchangeAPIData() { result in
            self.buildExchangeCellModel(data: result)
        }
    }
    
    func getCurrentCurrencyText() -> String {
        if let currentCurrency = currentCurrency {
            return "Current currency is : \(currentCurrency)"
        }
        
        return "Current currency is : Not Selected"
    }
    
    func getCountExchange() -> Int {
        exchangeDataArray.count
    }
    
    func getPairExchangeRate(_ currency: String, completion: @escaping () -> ()) {
        ExchangeAPIDataManager().getPairExchangeApiData(currencySelected: currency) { exchange in
            self.pairExchange = exchange
            completion()
        }
    }
    
    func getPairExchangeRate() -> Double {
        pairExchange
    }
    
    func getExchangeData(withIndex index: Int) -> ExchangeCellDataModel {
        return exchangeDataArray[index]
    }
    
    func buildExchangeCellModel(data: ExchangeDataModel) {
        let defaultExchange = XChangeConstants.defaultCurrencyToConvert
        var exchangeCellArray = [ExchangeCellDataModel]()
        for item in defaultExchange {
            exchangeCellArray.append(ExchangeCellDataModel(image: item, title: item, exchange: data.conversion_rates?[item] ?? 0.0))
        }
        exchangeDataArray = exchangeCellArray
        view?.reloadTableView()
    }
    
}
