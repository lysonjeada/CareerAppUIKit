//
//  ArticlesInteractorTests.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 15/04/25.
//

import XCTest
@testable import CareerAppUIKit

class ArticlesInteractorTests: XCTestCase {
    
    var interactor: ArticlesInteractor!
    var presenter: ArticlesPresenterSpy!
    var worker: ArticlesWorkerSpy!
    
    override func setUp() {
        super.setUp()
        presenter = .init()
        worker = .init()
        interactor = .init(presenter: presenter, worker: worker)
    }
    
    override func tearDown() {
        interactor = nil
        super.tearDown()
    }
    
    func testWhenArticlesFetchSuccessfully() {
        worker.isSuccess = true
        
        interactor.fetchArticles()
        
        XCTAssertTrue(presenter.presentArticlesCalled)
    }
    
}

class ArticlesPresenterSpy: ArticlesPresentationLogic {
    var presentArticlesCalled = false
    var presentErrorCalled = false
    
    func presentArticles(articles: [CareerAppUIKit.Article]) {
        presentArticlesCalled = true
    }
    
    func presentLoading(_ isLoading: Bool) {
        
    }
    
    func presentError(error: Error) {
        
    }
}

class ArticlesWorkerSpy: ArticlesWorkerProtocol {
    
    var isSuccess = false
    
    func fetchArticles(completion: @escaping (Result<[CareerAppUIKit.Article], any Error>) -> Void) {
        if isSuccess {
            completion(.success([]))
        } else {
            completion(.failure(NetworkError.decodingError))
        }
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
