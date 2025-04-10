//
//  LoginPresenter.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 08/04/25.
//

protocol LoginPresentationLogic {
    func presentLoginSuccess()
    func presentLoginError(_ error: String)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    func presentLoginSuccess() {
        viewController?.showLoginSuccess()
    }
    
    func presentLoginError(_ error: String) {
        viewController?.showLoginError(error)
    }
}
