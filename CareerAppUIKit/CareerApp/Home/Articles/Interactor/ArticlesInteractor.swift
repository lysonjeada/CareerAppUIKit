//
//  ArticlesInteractor.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

// MARK: - Protocols

protocol ArticlesBusinessLogic {
    func fetchArticles()
}

// MARK: - Interactor

class ArticlesInteractor: ArticlesBusinessLogic {
    var presenter: ArticlesPresentationLogic?
    var worker: ArticlesWorkerProtocol?
    
    init(presenter: ArticlesPresentationLogic?, worker: ArticlesWorkerProtocol?) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func fetchArticles() {
        self.presenter?.presentArticles(articles: [])
//        worker?.fetchArticles { [weak self] result in
//            switch result {
//            case .success(let articles):
//                self?.presenter?.presentArticles(articles: articles)
//            case .failure(let error):
//                self?.presenter?.presentError(error: error)
//            }
//        }
    }
}
