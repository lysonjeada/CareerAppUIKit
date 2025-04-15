//
//  ArticleDetailInteractor.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 14/04/25.
//

import Foundation

protocol ArticleDetailBusinessLogic {
    func fetchArticleDetail(id: Int)
}

class ArticleDetailInteractor: ArticleDetailBusinessLogic {
    var presenter: ArticleDetailPresentationLogic?
    var worker: ArticleDetailWorkerProtocol?
    var articleDetail: ArticleDetail?
    
    init(presenter: ArticleDetailPresentationLogic?, worker: ArticleDetailWorkerProtocol?) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func fetchArticleDetail(id: Int) {
        presenter?.presentLoading(true)
        worker?.fetchArticleDetail(id: id) { [weak self] result in
            self?.presenter?.presentLoading(false)
            switch result {
            case .success(let articleDetail):
                self?.articleDetail = articleDetail
                let response = ArticlesDetail.FetchArticle.Response(articleDetail: articleDetail, error: nil)
                self?.presenter?.presentArticleDetail(response: response)
            case .failure(let error):
                let response = ArticlesDetail.FetchArticle.Response(articleDetail: nil, error: error)
                self?.presenter?.presentArticleDetail(response: response)
            }
        }
    }
}
