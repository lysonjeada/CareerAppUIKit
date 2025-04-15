//
//  ArticleDetailFactory.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 15/04/25.
//

enum ArticleDetailFactory {
    static func build(id: Int) -> ArticleDetailViewController {
        let viewController = ArticleDetailViewController(id: id)
        let presenter = ArticleDetailPresenter()
        let worker = ArticleDetailWorker()
        viewController.interactor = ArticleDetailInteractor(presenter: presenter, worker: worker)
        presenter.viewController = viewController
        return viewController
    }
}
