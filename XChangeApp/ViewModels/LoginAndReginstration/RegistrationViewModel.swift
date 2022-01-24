//
//  RegistrationViewModel.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/21/22.
//

import Foundation

enum LoginAndRegistrationValidationError: Error {
    case tooShortPassword
    case withoutEspecialCharacter
    case wrongPassword
    case wrongEmailFormat
    case emptyTextFields
    case userHasAlreadyAccount
    case userHasNotAccount
}

protocol RegistrationViewModelProtocol {
    func userDataVerification(data: RegistrationDataModel) -> String?
}

class RegistrationViewModel: RegistrationViewModelProtocol {
    func userDataVerification(data: RegistrationDataModel) -> String? {
        do {
            try verifyDataValidation(data: data)
        } catch {
            return error.localizedDescription
        }
        XChangeUserDefaultManager.shared.saveUserVerified(data: data)
        return nil
    }
   
    private func verifyDataValidation(data: RegistrationDataModel) throws {
        guard let name = data.name, name.count > 0 , let email = data.email, email.count > 0, let password = data.password, password.count > 0, let repeatPasswordOne = data.repeatPaswordOne, repeatPasswordOne.count > 0, let repeatPasswordTwo = data.repeatPasswordTwo, repeatPasswordTwo.count > 0 else {
            throw LoginAndRegistrationValidationError.emptyTextFields
        }
        
        
        guard  email.isValidEmail() else  {
            throw LoginAndRegistrationValidationError.wrongEmailFormat
        }
        guard password.count >= 8 else {
            throw LoginAndRegistrationValidationError.tooShortPassword
        }
        guard password.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) != nil  else  {
            throw LoginAndRegistrationValidationError.withoutEspecialCharacter
        }
        guard repeatPasswordOne == repeatPasswordTwo, password == repeatPasswordOne else {
            throw LoginAndRegistrationValidationError.wrongPassword
        }
        
        guard !XChangeUserDefaultManager.shared.checkIfUserHasAlreadyAnAccount(email: email) else {
            throw LoginAndRegistrationValidationError.userHasAlreadyAccount
        }
        
    }
    
    
}
