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
    var userEmail: String?
    var authToken: String?
    
    weak var loginViewController: LoginViewController?
    
    func routeToArticles() {
        let viewController = ArticlesFactory.build()
        loginViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
