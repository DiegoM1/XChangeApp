//
//  CryptoDataModel.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/23/22.
//

import Foundation

struct CryptoAssetsDataModel: Codable {
    var assets: [CryptoDataModel]
}
struct CryptoAssetDataModel: Codable{
    var asset: CryptoDataModel
}

struct CryptoDataModel: Codable {
    let asset_id: String
    let price: Double
    let status: String
    let description: String?
}

class CryptoAPIDataManager {
    
    var viewModel: CryptoExchangeViewModelProtocol
    init(viewModel: CryptoExchangeViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func fetchCryptoData(withSize size: Int,andPage page: Int) {
        let urlString = "https://www.cryptingup.com/api/assets?size=\(size)&start=\(page)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.fetchDataGeneric(at: url, type: CryptoAssetsDataModel.self) { result in
            switch result {
            case .success(let sucess):
                let cellData = self.buildExchangeCellData(data: sucess.assets)
                self.viewModel.getFetchCryptoData(data: cellData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCryptoData(withId id: String, completion: @escaping (CryptoAssetDataModel) -> ()) {
        let urlString = "https://www.cryptingup.com/api/assets/\(id)"
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.fetchDataGeneric(at: url, type: CryptoAssetDataModel.self) { result in
            switch result {
            case .success(let sucess):
                completion(sucess)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func buildExchangeCellData(data: [CryptoDataModel]) -> [ExchangeCellDataModel] {
        var exchangeCellArray = [ExchangeCellDataModel]()
        for item in data {
            exchangeCellArray.append(ExchangeCellDataModel(image: "c.square.fill", title: item.asset_id, exchange: item.price, description: item.description))
        }
        return exchangeCellArray
    }
}
