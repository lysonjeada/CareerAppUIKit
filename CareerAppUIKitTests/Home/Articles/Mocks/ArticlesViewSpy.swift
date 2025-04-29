//
//  ArticlesViewSpy.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 28/04/25.
//

@testable import CareerAppUIKit

final class ArticlesViewSpy: ArticlesDisplayLogic {
    
    // MARK: - Call Tracking
    private(set) var displayArticlesCallCount = 0
    private(set) var displayLoadingCallCount = 0
    private(set) var displayErrorCallCount = 0
    private(set) var lastDisplayedArticles: [DisplayedArticle]?
    private(set) var lastLoadingState: Bool?
    private(set) var lastErrorMessage: String?
    
    // MARK: - ArticlesDisplayLogic
    func displayArticles(viewModel: Articles.FetchArticles.ViewModel) {
        displayArticlesCallCount += 1
        lastDisplayedArticles = viewModel.displayedArticles
    }
    
    func displayLoading(viewModel: Articles.PresentLoading.Response) {
        displayLoadingCallCount += 1
        lastLoadingState = viewModel.isLoading
    }
    
    func displayError(viewModel: Articles.PresentError.Response) {
        displayErrorCallCount += 1
        lastErrorMessage = viewModel.errorMessage
    }
    
    func displayArticleDetail(_ articleDetail: ArticleDetail) {
        // Implementação se necessário
    }
    
    // MARK: - Test Helpers
    func reset() {
        displayArticlesCallCount = 0
        displayLoadingCallCount = 0
        displayErrorCallCount = 0
        lastDisplayedArticles = nil
        lastLoadingState = nil
        lastErrorMessage = nil
    }
}
