//
//  ArticlesViewControllerTests.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 16/04/25.
//

import XCTest
@testable import CareerAppUIKit

class ArticlesDataStoreSpy: ArticlesDataStoreProtocol {
    var displayedArticles: [DisplayedArticle] = []
}

class ArticlesViewControllerTests: XCTestCase {
    
    var view: ArticlesViewController!
    var interactor: ArticlesInteractorSpy!
    var dataStore: ArticlesDataStoreSpy!
    
    override func setUp() {
        super.setUp()
        interactor = .init()
        dataStore = .init()
        view = .init(interactor: interactor, dataStore: dataStore)
    }

    func testWhenDidSelectArticle() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let indexPath = IndexPath(item: 0, section: 0)
        
        let displayedArticle =  DisplayedArticle(id: 1, title: "Test", description: "Test", publishDate: "14/04", imageUrl: nil, authorName: "Test", tags: "Teste, Teste")
        dataStore.displayedArticles = [displayedArticle]
        
        view.collectionView(collectionView, didSelectItemAt: indexPath)
        
        XCTAssertTrue(interactor.didSelectArticleCalled)
    }
}


class ArticlesInteractorSpy: ArticlesBusinessLogic {
    var fetchArticlesCalled = false
    var didSelectArticleCalled = false
    
    func fetchArticles(request: CareerAppUIKit.Articles.FetchArticles.Request) {
        fetchArticlesCalled = true
    }
    
    func didSelectArticle(request: CareerAppUIKit.Articles.DidSelectArticle.Request) {
        didSelectArticleCalled = true
    }
}
