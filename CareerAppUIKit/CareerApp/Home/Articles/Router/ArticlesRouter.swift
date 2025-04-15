//
//  ArticlesRouter.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

import Foundation

// MARK: - Router

protocol ArticlesRoutingLogic {
    var selectedArticleId: Int? { get set }
    var articleDetail: ArticleDetail? { get set }
    func routeToArticleDetail(id: Int)
}

protocol ArticlesDataStore {
    var selectedArticleId: Int? { get set }
    var articleDetail: ArticleDetail? { get set }
}

class ArticlesRouter: NSObject, ArticlesRoutingLogic, ArticlesDataStore {
    weak var viewController: ArticlesViewController?
    var selectedArticleId: Int?
    var articleDetail: ArticleDetail?
    
    func routeToArticleDetail(id: Int) {
        let detailVC = ArticleDetailViewController(id: id)
        let presenter = ArticleDetailPresenter()
        let worker = ArticleDetailWorker()
        detailVC.interactor = ArticleDetailInteractor(presenter: presenter, worker: worker)
        
        presenter.viewController = detailVC
//        detailVC.router?.dataStore?.articleDetail = articleDetail
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
