//
//  Extensions.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/21/22.
//

import Foundation
import UIKit

extension UITextField {
    func setupDefaultStyle(withPlaceholder placeholder: String? = nil, isSecurityTextEntry: Bool = false) {
        if let placeholder = placeholder {
            self.placeholder = placeholder
        }
        self.borderStyle = .roundedRect
        self.isSecureTextEntry = isSecurityTextEntry
    }
}

extension UIButton {
    func setupDefaultStyle(withTitle title: String? = nil,backgroundColor color: UIColor, andTintColor tintColor: UIColor, andBorderColor borderColor: UIColor) {
        if let title = title {
            self.setTitle(title, for: .normal)
        }
        self.backgroundColor = color
        self.tintColor = tintColor
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

// Dont change any string bellow or will destroy unit tests
extension LoginAndRegistrationValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .tooShortPassword:
            return NSLocalizedString(
                "Check password need to have atleast 8 characters",
                comment: ""
            )
        case .withoutEspecialCharacter:
            return NSLocalizedString(
                "Check password need to contain an especial character minimun",
                comment: ""
            )
        case .wrongPassword:
            return NSLocalizedString(
                "Check password it is wrong",
                comment: ""
            )
        case .wrongEmailFormat:
            return NSLocalizedString(
                "Check email it is not available",
                comment: ""
            )
        case .emptyTextFields:
            return NSLocalizedString(
                "Check text fields all of them  need to be full up",
                comment: ""
            )
        case .userHasAlreadyAccount:
            return NSLocalizedString(
                "Your email is already saved, go back and log In"
                , comment: "")
        case .userHasNotAccount:
            return NSLocalizedString(
                "There is not account created with that email, please sign up"
                , comment: "")
        }
    
        
    }
}
extension URLSession {
    
    func fetchDataExchangeRate(at url: URL, completion: @escaping (Result<ExchangeDataModel, Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let exchangeData = try JSONDecoder().decode(ExchangeDataModel.self, from: data)
                    completion(.success(exchangeData))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
    
    func fetchDataGeneric<T: Codable>(at url: URL, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let exchangeData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(exchangeData))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
    
    
}
