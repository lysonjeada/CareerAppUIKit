//
//  ArticlesPresenterSpy.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 28/04/25.
//

@testable import CareerAppUIKit

final class ArticlesPresenterSpy: ArticlesPresentationLogic {
    
    // MARK: - Call Tracking
    private(set) var presentArticlesCallCount = 0
    private(set) var presentErrorCallCount = 0
    private(set) var presentLoadingCallCount = 0
    private(set) var lastArticlesResponse: Articles.FetchArticles.Response?
    private(set) var lastErrorResponse: Articles.PresentError.Response?
    private(set) var lastLoadingResponse: Articles.PresentLoading.Response?
    
    // MARK: - ArticlesPresentationLogic
    func presentArticles(response: Articles.FetchArticles.Response) {
        presentArticlesCallCount += 1
        lastArticlesResponse = response
    }
    
    func presentError(response: Articles.PresentError.Response) {
        presentErrorCallCount += 1
        lastErrorResponse = response
    }
    
    func presentLoading(response: Articles.PresentLoading.Response) {
        presentLoadingCallCount += 1
        lastLoadingResponse = response
    }
    
    // MARK: - Test Helpers
    func reset() {
        presentArticlesCallCount = 0
        presentErrorCallCount = 0
        presentLoadingCallCount = 0
        lastArticlesResponse = nil
        lastErrorResponse = nil
        lastLoadingResponse = nil
    }
}
