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
    func getExchangeCellData(data: [ExchangeCellDataModel])
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
    
    private var exchangeDataArray = [ExchangeCellDataModel]()
    func viewDidLoad() {
        if currentCurrency == nil {
            ExchangeAPIDataManager(viewModel: self).getExchangeAPIData()
            
        } else if currentCurrency != XChangeUserDefaultManager.shared.getUserDefaultCurrency() {
            ExchangeAPIDataManager(viewModel: self).getExchangeAPIData()
        }
        currentCurrency = XChangeUserDefaultManager.shared.getUserDefaultCurrency()
    }
    
    func pullToRefresh() {
        ExchangeAPIDataManager(viewModel: self).getExchangeAPIData()
    }
    
    func getCurrentCurrencyText() -> String {
        if let currentCurrency = currentCurrency {
            return "Current currency is : \(currentCurrency)"
        }
        
        return "Current currency is : Not Selected"
    }
    func getExchangeCellData(data: [ExchangeCellDataModel]) {
        exchangeDataArray = data
        view?.reloadTableView()
    }
    
    func getCountExchange() -> Int {
        exchangeDataArray.count
    }
    
    func getPairExchangeRate(_ currency: String, completion: @escaping () -> ()) {
        ExchangeAPIDataManager(viewModel: self).getPairExchangeApiData(currencySelected: currency) { exchange in
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
    
}
