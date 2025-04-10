//
//  LoginRouter.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 08/04/25.
//

import Foundation
import UIKit

protocol LoginRoutingLogic {
    func routeToArticles()
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataStore {
    weak var viewController: LoginViewController?
    
    func routeToArticles() {
        let worker = ArticlesWorker()
        let presenter = ArticlesPresenter()
        
        let interactor = ArticlesInteractor(presenter: presenter, worker: worker)
        let router = ArticlesRouter()
        
        let vc = ArticlesViewController(interactor: interactor)
        let articlesViewController = UINavigationController(rootViewController: vc)
        presenter.viewController = vc
        articlesViewController.modalPresentationStyle = .fullScreen
        
        viewController?.present(articlesViewController, animated: true)
    }
}
