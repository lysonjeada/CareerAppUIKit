//
//  ArticleDetailPresenter.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 14/04/25.
//

// ArticleDetailPresenter.swift
protocol ArticleDetailPresentationLogic {
    func presentArticleDetail(response: ArticlesDetail.FetchArticle.Response)
    func presentLoading(_ isLoading: Bool)
}

class ArticleDetailPresenter: ArticleDetailPresentationLogic {
    weak var viewController: ArticleDetailDisplayLogic?
    
    func presentLoading(_ isLoading: Bool) {
        viewController?.displayLoading(isLoading)
    }
    
    func presentArticleDetail(response: ArticlesDetail.FetchArticle.Response) {
        if let error = response.error {
            viewController?.displayError(error.localizedDescription)
            return
        }
        
        guard let articleDetail = response.articleDetail else {
            viewController?.displayError("Article details not available")
            return
        }
        
        let displayedDetail = ArticlesDetail.DisplayedArticleDetail(
            title: articleDetail.title ?? "No title",
            description: articleDetail.description ?? "",
            coverImageURL: articleDetail.coverImage,
            readablePublishDate: articleDetail.readablePublishDate ?? "",
            readingTimeMinutes: articleDetail.readingTimeMinutes ?? 0,
            bodyHtml: articleDetail.bodyHtml ?? "",
            authorName: articleDetail.user?.name ?? "Unknown author",
            authorProfileImage: articleDetail.user?.profileImage
        )
        
        let viewModel = ArticlesDetail.FetchArticle.ViewModel(displayedArticleDetail: displayedDetail)
        viewController?.displayArticleDetail(viewModel)
    }
}
