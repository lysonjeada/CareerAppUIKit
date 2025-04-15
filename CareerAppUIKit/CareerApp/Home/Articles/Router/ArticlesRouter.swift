//
//  ArticlesRouter.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

import Foundation

protocol ArticlesRoutingLogic {
    func routeToArticleDetail(id: Int)
}

protocol ArticlesDataStore {}

// MARK: - Router

class ArticlesRouter: NSObject, ArticlesRoutingLogic, ArticlesDataStore {
    weak var viewController: ArticlesViewController?
    
    func routeToArticleDetail(id: Int) {
        let articleDetailViewController = ArticleDetailFactory.build(id: id)
        viewController?.navigationController?.pushViewController(articleDetailViewController, animated: true)
    }
}
