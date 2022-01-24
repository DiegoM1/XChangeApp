//
//  SettingsSwiftUIView.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/22/22.
//

import SwiftUI

struct SettingsSwiftUIView: View {
    @State var currentSelection: String = XChangeUserDefaultManager.shared.getUserDefaultCurrency()

    var body: some View {
        List() {
            Section("Main base currency") {
                Picker("Currency", selection: $currentSelection) {
                    ForEach(XChangeConstants.defaultCurrencyToConvert, id: \.self) { item in
                        Text("\(item)")
                    }
                }
                .onReceive([self.currentSelection].publisher) { value in
                    XChangeUserDefaultManager.shared.saveUserDefaultCurrency(value)
                }
            }
            Section("User") {
                Button("Logout") {
                    guard let loginVC = LoginViewController.instantiate() as? LoginViewController else {
                        return
                    }
                    loginVC.viewModel = LoginViewModel()
                    guard let window = UIApplication.shared.windows.first else {
                        return
                    }
                    
                    window.rootViewController = UINavigationController(rootViewController: loginVC)
                    let options: UIView.AnimationOptions = .curveLinear
                    let duration: TimeInterval = 0.3
                    UIView.transition(with: window,
                                      duration: duration,
                                      options: options,
                                      animations: nil)
                }
                .tint(.red)
            }
        }
    }
}

struct SettingsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSwiftUIView()
    }
}
