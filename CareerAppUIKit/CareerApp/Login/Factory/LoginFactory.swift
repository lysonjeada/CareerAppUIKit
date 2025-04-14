//
//  LoginFactory.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 10/04/25.
//

enum LoginFactory {
    static func build() -> LoginViewController {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        let viewController = LoginViewController()
        viewController.interactor = interactor
        interactor.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.loginViewController = viewController
        return viewController
    }
}
