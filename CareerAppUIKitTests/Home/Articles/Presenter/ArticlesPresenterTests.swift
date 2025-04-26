//
//  ArticlesPresenterTests.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 15/04/25.
//

import XCTest
@testable import CareerAppUIKit

class ArticlesPresenterTests: XCTestCase {
    
    var presenter: ArticlesPresenter!
    var view: ArticlesViewSpy!
    
    override func setUp() {
        super.setUp()
        presenter = .init()
        view = .init()
        presenter.viewController = view
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func testWhenArticlesFetchSuccessfully() {
        // Given
        let articles = loadArticlesFromJSON()
        
        // When
        presenter.presentArticles(response: .init(articles: articles))
        
        // Then
        XCTAssertTrue(view.displayArticlesCalled)
        XCTAssertEqual(view.articles?.displayedArticles.count, 2)
        XCTAssertEqual(view.articles?.displayedArticles[0].title, "Getting Started with SwiftUI")
        XCTAssertEqual(view.articles?.displayedArticles[1].title, "Advanced Combine Techniques")
    }
    
    private func loadArticlesFromJSON() -> [Article] {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "articles", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("Failed to load JSON file")
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Article].self, from: data)
        } catch {
            XCTFail("Failed to decode JSON: \(error)")
            return []
        }
    }
    
    
}

class ArticlesViewSpy: ArticlesDisplayLogic {
    
    var articles: Articles.FetchArticles.ViewModel?
    
    var displayArticlesCalled = false
    var displayErrorCalled = false
    
    func displayError(viewModel: CareerAppUIKit.Articles.PresentError.Response) {
        
    }
    
    func displayLoading(viewModel: CareerAppUIKit.Articles.PresentLoading.Response) {
        
    }
    
    func displayArticles(viewModel: CareerAppUIKit.Articles.FetchArticles.ViewModel) {
        displayArticlesCalled = true
    }
    
    func displayArticleDetail(_ articleDetail: CareerAppUIKit.ArticleDetail) {
        
    }
}
