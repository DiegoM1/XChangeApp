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
    
    func fetchCryptoData(withSize size: Int,andPage page: Int, completion: @escaping ([CryptoDataModel]) -> (Void)) {
        let urlString = "https://www.cryptingup.com/api/assets?size=\(size)&start=\(page)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.fetchDataGeneric(at: url, type: CryptoAssetsDataModel.self) { result in
            switch result {
            case .success(let sucess):
                completion(sucess.assets)
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
}
