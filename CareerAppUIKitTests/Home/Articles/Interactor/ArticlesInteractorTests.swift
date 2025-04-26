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
        interactor = .init(presenter: presenter, worker: worker, router: ArticlesRouterSpy())
    }
    
    override func tearDown() {
        interactor = nil
        super.tearDown()
    }
    
    func testWhenArticlesFetchSuccessfully() {
        worker.isSuccess = true
        
        interactor.fetchArticles(request: .init())
        
        XCTAssertTrue(presenter.presentArticlesCalled)
    }
    
}

class ArticlesPresenterSpy: ArticlesPresentationLogic {
    var presentArticlesCalled = false
    var presentErrorCalled = false
    var presentLoadingCalled = false
    
    func presentArticles(response: CareerAppUIKit.Articles.FetchArticles.Response) {
        presentArticlesCalled = true
    }
    
    func presentError(response: CareerAppUIKit.Articles.PresentError.Response) {
        presentErrorCalled = true
    }
    
    func presentLoading(response: CareerAppUIKit.Articles.PresentLoading.Response) {
        presentLoadingCalled = true
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

class ArticlesRouterSpy: ArticlesRoutingLogic {
    func routeToArticleDetail(id: Int) {
        
    }
}


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
