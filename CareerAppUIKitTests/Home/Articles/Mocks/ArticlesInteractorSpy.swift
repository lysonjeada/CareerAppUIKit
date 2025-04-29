//
//  ArticlesInteractorSpy.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 28/04/25.
//

@testable import CareerAppUIKit

final class ArticlesInteractorSpy: ArticlesBusinessLogic {
    
    // MARK: - Call Tracking
    private(set) var fetchArticlesCallCount = 0
    private(set) var didSelectArticleCallCount = 0
    private(set) var lastFetchRequest: Articles.FetchArticles.Request?
    private(set) var lastSelectRequest: Articles.DidSelectArticle.Request?
    
    // MARK: - ArticlesBusinessLogic
    func fetchArticles(request: Articles.FetchArticles.Request) {
        fetchArticlesCallCount += 1
        lastFetchRequest = request
    }
    
    func didSelectArticle(request: Articles.DidSelectArticle.Request) {
        didSelectArticleCallCount += 1
        lastSelectRequest = request
    }
    
    // MARK: - Test Helpers
    func reset() {
        fetchArticlesCallCount = 0
        didSelectArticleCallCount = 0
        lastFetchRequest = nil
        lastSelectRequest = nil
    }
}
