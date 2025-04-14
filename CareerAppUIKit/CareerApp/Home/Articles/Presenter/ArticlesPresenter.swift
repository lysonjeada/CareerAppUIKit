//
//  ArticlesPresenter.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

protocol ArticlesPresentationLogic {
    func presentArticles(articles: [Article])
    func presentError(error: Error)
}

// MARK: - Presenter

class ArticlesPresenter: ArticlesPresentationLogic {
    weak var viewController: ArticlesDisplayLogic?
    
    func presentArticles(articles: [Article]) {
        if articles.isEmpty {
            viewController?.displayArticlesEmpty()
        } else {
            let displayedArticles = articles.map { article in
                Articles.FetchArticles.ViewModel.DisplayedArticle(
                    title: article.title,
                    description: article.description,
                    publishDate: article.readablePublishDate,
                    imageUrl: article.coverImage,
                    authorName: article.user.name,
                    tags: article.tags
                )
            }
            
            let viewModel = Articles.FetchArticles.ViewModel(displayedArticles: displayedArticles)
            viewController?.displayArticles(viewModel)
        }
    }
    
    func presentError(error: Error) {
        viewController?.displayError(error.localizedDescription)
    }
}
