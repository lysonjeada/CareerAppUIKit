//
//  ArticlesFactory.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 10/04/25.
//

enum ArticlesFactory {
    static func build() -> ArticlesViewController {
        let worker = ArticlesWorker()
        let presenter = ArticlesPresenter()
        let router = ArticlesRouter()
        let interactor = ArticlesInteractor(presenter: presenter, worker: worker, router: router)
        let viewController = ArticlesViewController(interactor: interactor)
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
