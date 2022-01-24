//
//  ExchangeDataModel.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/22/22.
//

import Foundation

protocol ExchangeDataModelProtocol {
    
}

struct ExchangeCellDataModel {
    var image: String
    var title: String
    var exchange: Double
    var description: String?
}

struct ExchangeDataModel: Codable {
    var result: String?
    var time_last_update_utc: String
    var time_next_update_utc: String
    var base_code: String
    var conversion_rates: [String: Double]?
}

struct PairExchangeDataModel: Codable {
    var result: String?
    var time_last_update_utc: String
    var time_next_update_utc: String
    var base_code: String
    var conversion_rate: Double
}


class ExchangeAPIDataManager {
    
    func getExchangeAPIData(completion: @escaping (ExchangeDataModel) -> ()) {
        let userCurrency: String = XChangeUserDefaultManager.shared.getUserDefaultCurrency()
        let urlString = "https://v6.exchangerate-api.com/v6/\(XChangeConstants.apiKey)/latest/\(userCurrency)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.fetchDataExchangeRate(at: url) { result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPairExchangeApiData(currencySelected: String, completion: @escaping (Double) -> ()) {
        let userCurrency: String = XChangeUserDefaultManager.shared.getUserDefaultCurrency()
        let urlString = "https://v6.exchangerate-api.com/v6/\(XChangeConstants.apiKey)/pair/\(userCurrency)/\(currencySelected)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.fetchDataGeneric(at: url,type: PairExchangeDataModel.self, completion: { result in
            switch result {
            case .success(let result):
                completion(result.conversion_rate)
            case .failure(let error):
                print(error)
               completion(0.0)
            }
        })
        
    }
    
    func buildExchangeCellModel(data: ExchangeDataModel) -> [ExchangeCellDataModel] {
        let defaultExchange = XChangeConstants.defaultCurrencyToConvert
        var exchangeCellArray = [ExchangeCellDataModel]()
        for item in defaultExchange {
            exchangeCellArray.append(ExchangeCellDataModel(image: item, title: item, exchange: data.conversion_rates?[item] ?? 0.0))
        }
        return exchangeCellArray
    }
}


