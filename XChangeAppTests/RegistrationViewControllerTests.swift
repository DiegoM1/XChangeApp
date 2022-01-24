//
//  RegistrationViewController.swift
//  XChangeAppTests
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/21/22.
//

import XCTest
@testable import XChangeApp

class RegistrationViewControllerTests: XCTestCase {
    
    let viewModel = RegistrationViewModel()
    
    private let user1 = RegistrationDataModel(name: "ddd", email: "ddd", password: "ddd", repeatPaswordOne: "", repeatPasswordTwo: "")
    private let user2 = RegistrationDataModel(name: "diego M", email: "dasdasdads", password: "123456789*", repeatPaswordOne: "123456789*", repeatPasswordTwo: "123456789*")
    private let user3 = RegistrationDataModel(name: "diego M", email: "dasdasdads@gmail.com", password: "123456789*", repeatPaswordOne: "12345", repeatPasswordTwo: "123456789*")
    private let user4 = RegistrationDataModel(name: "diego M", email: "dasdasdads@gmail.com", password: "1234*", repeatPaswordOne: "1234*", repeatPasswordTwo: "1234*")
    private let user5 = RegistrationDataModel(name: "diego M", email: "dasdasdads@gmail.com", password: "123456789", repeatPaswordOne: "123456789", repeatPasswordTwo: "123456789")
    
    

    func testEmptyFields() {
        XCTAssertTrue(viewModel.userDataVerification(data:user1) == "Check text fields all of them  need to be full up")
    }
    
    func testWrongEmail() {
        XCTAssertTrue(viewModel.userDataVerification(data:user2) == "Check email it is not available")
    }
    
    func testPasswordsAreNotSimilar() {
        XCTAssertTrue(viewModel.userDataVerification(data:user3) == "Check password it is wrong")
    }
    
    func testPasswordTooShort() {
        XCTAssertTrue(viewModel.userDataVerification(data:user4) == "Check password need to have atleast 8 characters")
    }
    
    func testPasswordWithoutEspecialCharacter() {
        XCTAssertTrue(viewModel.userDataVerification(data:user5) == "Check password need to contain an especial character minimun,")
    }
    
    
    
}
