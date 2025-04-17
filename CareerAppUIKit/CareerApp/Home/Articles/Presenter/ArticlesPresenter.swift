//
//  ArticlesPresenter.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

protocol ArticlesPresentationLogic {
    func presentArticles(response: Articles.FetchArticles.Response)
    func presentError(response: Articles.PresentError.Response)
    func presentLoading(response: Articles.PresentLoading.Response)
}

// MARK: - Presenter

class ArticlesPresenter: ArticlesPresentationLogic {
    weak var viewController: ArticlesDisplayLogic?
    
    func presentLoading(response: Articles.PresentLoading.Response) {
        viewController?.displayLoading(viewModel: response)
    }
    
    func presentArticles(response: Articles.FetchArticles.Response) {
        let displayedArticles = response.articles.map { article in
            DisplayedArticle(
                id: article.id,
                title: article.title,
                description: article.description,
                publishDate: article.readablePublishDate,
                imageUrl: article.coverImage,
                authorName: article.user.name,
                tags: article.tags
            )
        }
        let viewModel = Articles.FetchArticles.ViewModel(displayedArticles: displayedArticles)
        viewController?.displayArticles(viewModel: viewModel)
    }
    
    func presentError(response: Articles.PresentError.Response) {
        viewController?.displayError(viewModel: response)
    }
}
