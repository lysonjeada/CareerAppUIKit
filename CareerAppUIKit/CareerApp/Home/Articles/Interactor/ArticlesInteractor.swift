//
//  ArticlesInteractor.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

import Foundation

// MARK: - Protocols

protocol ArticlesBusinessLogic {
    func fetchArticles(request: Articles.FetchArticles.Request)
    func didSelectArticle(request: Articles.DidSelectArticle.Request)
}

// MARK: - Interactor

class ArticlesInteractor: ArticlesBusinessLogic {
    let presenter: ArticlesPresentationLogic
    let worker: ArticlesWorkerProtocol
    let router: ArticlesRoutingLogic
    
    init(presenter: ArticlesPresentationLogic, worker: ArticlesWorkerProtocol, router: ArticlesRoutingLogic) {
        self.presenter = presenter
        self.worker = worker
        self.router = router
    }
    
    func fetchArticles(request: Articles.FetchArticles.Request) {
        presenter.presentLoading(response: .init(isLoading: true))
        worker.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.presenter.presentArticles(response: .init(articles: articles))
            case .failure(let error):
                self?.presenter.presentError(response: .init(errorMessage: error.localizedDescription))
            }
            self?.presenter.presentLoading(response: .init(isLoading: false))
        }
    }
    
    func didSelectArticle(request: Articles.DidSelectArticle.Request) {
        router.routeToArticleDetail(id: request.id)
    }
}
