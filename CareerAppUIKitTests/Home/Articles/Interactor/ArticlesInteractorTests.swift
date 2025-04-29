//
//  ArticlesInteractorTests.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 15/04/25.
//

import XCTest
@testable import CareerAppUIKit

final class ArticlesInteractorTests: XCTestCase {
    
    // MARK: - Properties
    private var interactor: ArticlesInteractor?
    private var presenter: ArticlesPresenterSpy?
    private var worker: ArticlesWorkerSpy?
    private var router: ArticlesRouterSpy?
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        setupTestComponents()
    }
    
    override func tearDown() {
        cleanUpTestComponents()
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func test_givenSuccessfulResponse_whenFetchingArticles_shouldPresentArticles() {
        // Given
        guard let worker = worker, let presenter = presenter else {
            return XCTFail("Test dependencies not properly initialized")
        }
        
        worker.stubSuccessResponse(with: [])
        
        // When
        interactor?.fetchArticles(request: Articles.FetchArticles.Request())
        
        // Then
        XCTAssertEqual(presenter.presentArticlesCallCount, 1, "Should call present articles exactly once")
        XCTAssertEqual(presenter.presentErrorCallCount, 0, "Should not call present error")
        XCTAssertNotNil(presenter.lastArticlesResponse, "Should receive articles response")
    }
    
    func test_givenFailedResponse_whenFetchingArticles_shouldPresentError() {
        // Given
        guard let worker = worker, let presenter = presenter else {
            return XCTFail("Test dependencies not properly initialized")
        }
        
        let expectedError = NetworkError.decodingError
        worker.stubFailureResponse(with: expectedError)
        
        // When
        interactor?.fetchArticles(request: Articles.FetchArticles.Request())
        
        // Then
        XCTAssertEqual(presenter.presentErrorCallCount, 1, "Should call present error exactly once")
        XCTAssertEqual(presenter.presentArticlesCallCount, 0, "Should not call present articles")
        XCTAssertEqual(presenter.lastErrorResponse?.errorMessage, expectedError.localizedDescription)
    }
    
    func test_givenArticleSelection_whenSelectingArticle_shouldRouteToDetail() {
        // Given
        guard let router = router else {
            return XCTFail("Router dependency not properly initialized")
        }
        
        let testId = 123
        let request = Articles.DidSelectArticle.Request(id: testId)
        
        // When
        interactor?.didSelectArticle(request: request)
        
        // Then
        XCTAssertEqual(router.routeToArticleDetailCallCount, 1, "Should call route to detail exactly once")
        XCTAssertEqual(router.routedArticleIds.first, testId, "Should route with correct article ID")
    }
    
    // MARK: - Helper Methods
    private func setupTestComponents() {
        let newPresenter = ArticlesPresenterSpy()
        let newWorker = ArticlesWorkerSpy()
        let newRouter = ArticlesRouterSpy()
        
        presenter = newPresenter
        worker = newWorker
        router = newRouter
        
        interactor = ArticlesInteractor(
            presenter: newPresenter,
            worker: newWorker,
            router: newRouter
        )
    }
    
    private func cleanUpTestComponents() {
        interactor = nil
        presenter?.reset()
        presenter = nil
        worker?.reset()
        worker = nil
        router?.reset()
        router = nil
    }
}
