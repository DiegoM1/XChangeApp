//
//  CryptoExchangeViewModel.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/23/22.
//

import Foundation

protocol CryptoExchangeViewControllerProtocol {
    func reloadTableView()
}

protocol CryptoExchangeViewModelProtocol {
    var view: CryptoExchangeViewControllerProtocol? { get set }
    func viewDidLoad()
    func initialFetchCryptoExchangeData()
    func fetchCryptoExchangeData()
    func getCryptoDataCount() -> Int
    func getFetchCryptoData(data: [ExchangeCellDataModel])
    func getCryptoData(withIndex index: Int) -> ExchangeCellDataModel
    func filterCyrptoExchangeData(withText text: String)
}
class CryptoExchangeViewModel: CryptoExchangeViewModelProtocol {
    
    var view: CryptoExchangeViewControllerProtocol?
    private var cryptoAPIManager: CryptoAPIDataManager?
    private var page = 1
    
    private var cryptoExchangeArray: [ExchangeCellDataModel] = [ExchangeCellDataModel]()
    private var cryptoExchangeArrayFiltered: [ExchangeCellDataModel] = [ExchangeCellDataModel]()
    
    func viewDidLoad() {
        cryptoAPIManager = CryptoAPIDataManager(viewModel: self)
        initialFetchCryptoExchangeData()
    }
    
    func initialFetchCryptoExchangeData() {
        cryptoAPIManager?.fetchCryptoData(withSize: 20, andPage: 1)
    }
    
    func fetchCryptoExchangeData() {
        page += 1
        cryptoAPIManager?.fetchCryptoData(withSize: 20 * page, andPage: 1)
    }
    
    func getFetchCryptoData(data: [ExchangeCellDataModel]) {
        cryptoExchangeArray = data
        cryptoExchangeArrayFiltered = data
        view?.reloadTableView()
    }
    
    func getCryptoDataCount() -> Int {
        cryptoExchangeArrayFiltered.count
    }
    
    func getCryptoData(withIndex index: Int) -> ExchangeCellDataModel {
        cryptoExchangeArrayFiltered[index]
    }
    
    func filterCyrptoExchangeData(withText text: String) {
        if text.count == 0 {
            cryptoExchangeArrayFiltered = cryptoExchangeArray
        } else {
            cryptoExchangeArrayFiltered = cryptoExchangeArray.filter { $0.title.contains(text)}
        }
        view?.reloadTableView()
    }
}
