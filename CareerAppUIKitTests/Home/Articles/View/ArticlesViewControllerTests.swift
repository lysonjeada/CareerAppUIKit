//
//  ArticlesViewControllerTests.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 16/04/25.
//

import XCTest
@testable import CareerAppUIKit

class ArticlesViewControllerTests: XCTestCase {
    
    var view: ArticlesViewController!
    var interactor: ArticlesInteractorSpy!
    
    override func setUp() {
        super.setUp()
        interactor = .init()
        view = .init(interactor: interactor)
    }
    
    override func tearDown() {
        view = nil
        super.tearDown()
    }
    
    func testWhenArticlesFetchSuccessfully() {
        view.viewDidLoad()
        
        XCTAssertTrue(interactor.fetchArticlesCalled)
    }
    
    func testWhenDidSelectArticle() {
        view.viewDidLoad()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let indexPath = IndexPath(item: 0, section: 0)
        
        let displayedArticle =  Articles.FetchArticles.ViewModel.DisplayedArticle(id: 1, title: "Test", description: "Test", publishDate: "14/04", imageUrl: nil, authorName: "Test", tags: "Teste, Teste")
        view.articles = Articles.FetchArticles.ViewModel(displayedArticles: [displayedArticle])
        
        view.collectionView(collectionView, didSelectItemAt: indexPath)
        
        XCTAssertTrue(interactor.didSelectArticleCalled)
    }
    
}

class ArticlesInteractorSpy: ArticlesBusinessLogic {
    var fetchArticlesCalled = false
    var didSelectArticleCalled = false
    
    func fetchArticles() {
        fetchArticlesCalled = true
    }
    
    func didSelectArticle(id: Int) {
        didSelectArticleCalled = true
    }
}
