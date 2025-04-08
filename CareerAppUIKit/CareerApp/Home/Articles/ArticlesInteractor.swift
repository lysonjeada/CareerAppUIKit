//
//  ArticlesInteractor.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

// MARK: - Protocols

protocol ArticlesDisplayLogic: AnyObject {
    func displayArticles(_ articles: [Article])
    func displayError(_ error: String)
}

protocol ArticlesBusinessLogic {
    var articles: [Article] { get }
    func fetchArticles(request: Articles.FetchArticles.Request)
}

// MARK: - Interactor

class ArticlesInteractor: ArticlesBusinessLogic {
    var presenter: ArticlesPresentationLogic?
    var worker: ArticlesWorkerProtocol?
    var articles: [Article] = []
    
    init(presenter: ArticlesPresentationLogic?, worker: ArticlesWorkerProtocol?) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func fetchArticles(request: Articles.FetchArticles.Request) {
        worker?.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.presenter?.presentArticles(articles: articles)
            case .failure(let error):
                self?.presenter?.presentError(error: error)
            }
        }
    }
}
