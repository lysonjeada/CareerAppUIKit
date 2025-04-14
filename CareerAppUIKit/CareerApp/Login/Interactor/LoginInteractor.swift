//
//  LoginInteractor.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 08/04/25.
//

import Foundation

protocol LoginBusinessLogic {
    func login(request: Login.Login.Request)
    func loginWithoutCredentials()
    func routeToArticles()
}

typealias LoginRouterType = (NSObjectProtocol & LoginRoutingLogic & LoginDataStore)

class LoginInteractor: LoginBusinessLogic {
    var presenter: LoginPresentationLogic?
    var router: LoginRouterType?
    
    func login(request: Login.Login.Request) {
        if request.email.isEmpty || request.password.isEmpty {
            presenter?.presentLoginError("Email e senha são obrigatórios")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.presenter?.presentLoginSuccess()
        }
    }
    
    func loginWithoutCredentials() {
        presenter?.presentLoginSuccess()
    }
    
    func routeToArticles() {
        router?.routeToArticles()
    }
}
