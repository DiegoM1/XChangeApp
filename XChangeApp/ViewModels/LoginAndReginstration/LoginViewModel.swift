//
//  LoginViewModel.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/21/22.
//

import Foundation



protocol LoginViewModelProtocol {
    func checkIfUserExist(data: LoginDataModel) -> String?
}

class LoginViewModel: LoginViewModelProtocol {
    func checkIfUserExist(data: LoginDataModel) -> String? {
        do {
            try verifyDataValidation(data: data)
        } catch {
            return error.localizedDescription
        }
        return nil
    }
    
    func verifyDataValidation(data: LoginDataModel) throws {
        guard let email = data.email, email.count > 0, let password = data.password, password.count > 0 else {
           throw LoginAndRegistrationValidationError.emptyTextFields
        }
        guard email.isValidEmail() else {
            throw LoginAndRegistrationValidationError.wrongEmailFormat
        }
        guard password.count >= 8 else {
            throw LoginAndRegistrationValidationError.tooShortPassword
        }
        guard password.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) != nil  else  {
            throw LoginAndRegistrationValidationError.withoutEspecialCharacter
        }
        guard XChangeUserDefaultManager.shared.checkIfUserHasAlreadyAnAccount(email: email) else {
            throw LoginAndRegistrationValidationError.userHasNotAccount
        }
        
        guard XChangeUserDefaultManager.shared.verifyUserToLogin(email: email, password: password) else {
            throw LoginAndRegistrationValidationError.wrongPassword
        }
    }
}
