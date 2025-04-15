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
        let interactor = ArticlesInteractor(presenter: presenter, worker: worker)
        let router = ArticlesRouter()
        let viewController = ArticlesViewController(interactor: interactor)
        router.viewController = viewController
        presenter.viewController = viewController
        interactor.router = router
        return viewController
    }
}
