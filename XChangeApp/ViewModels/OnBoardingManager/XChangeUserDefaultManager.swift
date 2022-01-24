//
//  OnBoardingManager.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/20/22.
//

import Foundation
import Security

class XChangeUserDefaultManager {
    static let shared = XChangeUserDefaultManager()
    
    var isFirstLaunch: Bool {
        get {
            UserDefaults.standard.bool(forKey: "OnBoardingShowed")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "OnBoardingShowed")
        }
    }
    
    
    func checkIfUserHasAlreadyAnAccount(email: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let existingItem = item as? [String: Any],
               let emailSaved = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                return true
            }
        } else {
            return false
        }
        return false
    }
    
    func saveUserVerified(data: RegistrationDataModel) {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: data.email!,
            kSecValueData as String: data.password!.data(using: .utf8)!,
        ]

        // Add user
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            print("User saved successfully in the keychain")
        } else {
            print("Something went wrong trying to save the user in the keychain")
        }
    }
    
    func verifyUserToLogin(email: String, password: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let existingItem = item as? [String: Any],
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let passwordKey = String(data: passwordData, encoding: .utf8)
            {
                return password == passwordKey ? true : false
            }
        } else {
            return false
        }
        return false
    }
    
    func saveUserDefaultCurrency(_ currency: String) {
        return UserDefaults.standard.set(currency, forKey: "UserCurrency")
    }
    
    func getUserDefaultCurrency() -> String {
        return UserDefaults.standard.string(forKey: "UserCurrency") ?? "USD"
    }
}
