//
//  ArticlesPresenterTests.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 15/04/25.
//

import XCTest
@testable import CareerAppUIKit

final class ArticlesPresenterTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: ArticlesPresenter?
    private var viewSpy: ArticlesViewSpy?
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        sut = ArticlesPresenter()
        viewSpy = ArticlesViewSpy()
        sut?.viewController = viewSpy
    }
    
    override func tearDown() {
        sut = nil
        viewSpy?.reset()
        viewSpy = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func test_presentArticles_shouldFormatAndDisplayData() throws {
        // Given
        let articles = try loadArticlesFromJSON()
        let response = Articles.FetchArticles.Response(articles: articles)
        let presenter = try XCTUnwrap(sut, "Presenter não deveria ser nil")
        let view = try XCTUnwrap(viewSpy, "ViewSpy não deveria ser nil")
        
        // When
        presenter.presentArticles(response: response)
        
        // Then
        XCTAssertEqual(view.displayArticlesCallCount, 1, "Deveria chamar displayArticles uma vez")
        XCTAssertEqual(view.lastDisplayedArticles?.count, articles.count, "Deveria exibir todos os artigos")
        XCTAssertEqual(view.lastDisplayedArticles?.first?.title, articles.first?.title, "Títulos deveriam corresponder")
    }
    
    func test_presentLoading_shouldUpdateViewState() throws {
        // Given
        let isLoading = true
        let presenter = try XCTUnwrap(sut, "Presenter não deveria ser nil")
        let view = try XCTUnwrap(viewSpy, "ViewSpy não deveria ser nil")
        
        // When
        presenter.presentLoading(response: Articles.PresentLoading.Response(isLoading: isLoading))
        
        // Then
        XCTAssertEqual(view.displayLoadingCallCount, 1, "Deveria chamar displayLoading uma vez")
        XCTAssertEqual(view.lastLoadingState, isLoading, "Estado de loading deveria ser true")
    }
    
    func test_presentError_shouldDisplayErrorMessage() throws {
        // Given
        let testError = NetworkError.noData
        let presenter = try XCTUnwrap(sut, "Presenter não deveria ser nil")
        let view = try XCTUnwrap(viewSpy, "ViewSpy não deveria ser nil")
        
        // When
        presenter.presentError(response: Articles.PresentError.Response(errorMessage: testError.localizedDescription))
        
        // Then
        XCTAssertEqual(view.displayErrorCallCount, 1, "Deveria chamar displayError uma vez")
        XCTAssertEqual(view.lastErrorMessage, testError.localizedDescription, "Mensagem de erro deveria corresponder")
    }
    
    // MARK: - Helper Methods
    
    private func loadArticlesFromJSON() throws -> [Article] {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "articles", withExtension: "json") else {
            throw NSError(domain: "Tests", code: 1, userInfo: [NSLocalizedDescriptionKey: "Arquivo JSON não encontrado"])
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode([Article].self, from: data)
    }
}
