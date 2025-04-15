//
//  ArticlesInteractor.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

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
                self?.presenter?.presentLoading(false)
                self?.presenter?.presentArticles(articles: articles)
            case .failure(let error):
                self?.presenter?.presentLoading(false)
                self?.presenter?.presentError(error: error)
            }
        }
    }
    
    func didSelectArticle(id: Int) {
        router?.selectedArticleId = id
        router?.routeToArticleDetail(id: id)
    }
}
