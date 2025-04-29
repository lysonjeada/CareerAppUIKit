//
//  ArticlesRouterSpy.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 28/04/25.
//

@testable import CareerAppUIKit

final class ArticlesRouterSpy: ArticlesRoutingLogic {
    
    // MARK: - Call Tracking
    private(set) var routeToArticleDetailCallCount = 0
    private(set) var routedArticleIds: [Int] = []
    
    // MARK: - ArticlesRoutingLogic
    func routeToArticleDetail(id: Int) {
        routeToArticleDetailCallCount += 1
        routedArticleIds.append(id)
    }
    
    // MARK: - Test Helpers
    func reset() {
        routeToArticleDetailCallCount = 0
        routedArticleIds = []
    }
}
