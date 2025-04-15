//
//  ArticlesInteractor.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

import Foundation

// MARK: - Protocols

protocol ArticlesBusinessLogic {
    func fetchArticles()
    func didSelectArticle(id: Int)
}

// MARK: - Interactor

class ArticlesInteractor: ArticlesBusinessLogic {
    var presenter: ArticlesPresentationLogic?
    var worker: ArticlesWorkerProtocol?
    var router: ArticlesRoutingLogic?
    
    init(presenter: ArticlesPresentationLogic?, worker: ArticlesWorkerProtocol?) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func fetchArticles() {
        presenter?.presentLoading(true)
        worker?.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.presenter?.presentArticles(articles: articles)
                self?.presenter?.presentLoading(false)
            case .failure(let error):
                self?.presenter?.presentError(error: error)
                self?.presenter?.presentLoading(false)
            }
        }
    }
    
    func didSelectArticle(id: Int) {
        router?.routeToArticleDetail(id: id)
    }
}
