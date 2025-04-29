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

final class ArticlesViewControllerTests: XCTestCase {
    
    // MARK: - Test Components
    private var sut: ArticlesViewController?
    private var interactorSpy: ArticlesInteractorSpy?
    private var dataStoreSpy: ArticlesDataStoreSpy?
    private let testCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        do {
            try setupTestComponents()
        } catch {
            XCTFail("Falha no setup: \(error.localizedDescription)")
        }
    }
    
    override func tearDown() {
        cleanUpTestComponents()
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func test_viewDidLoad_shouldFetchArticles() throws {
        // When
        _ = try XCTUnwrap(sut).view
        
        // Then
        XCTAssertEqual(interactorSpy?.fetchArticlesCallCount, 1)
    }
    
    func test_didSelectArticle_shouldNotifyInteractor() throws {
        // Given
        let testArticle = DisplayedArticle(
            id: 1, title: "Test", description: "Desc",
            publishDate: "Jan 1", imageUrl: nil,
            authorName: "Author", tags: "tag1,tag2"
        )
        dataStoreSpy?.displayedArticles = [testArticle]
        let indexPath = IndexPath(item: 0, section: 0)
        
        // When
        try XCTUnwrap(sut).collectionView(
            testCollectionView,
            didSelectItemAt: indexPath
        )
        
        // Then
        XCTAssertEqual(interactorSpy?.didSelectArticleCallCount, 1)
        XCTAssertEqual(try XCTUnwrap(interactorSpy?.lastSelectRequest?.id), 1)
    }
    
    func test_emptyState_shouldShowEmptyCell() throws {
        // Given
        dataStoreSpy?.displayedArticles = []
        let indexPath = IndexPath(item: 0, section: 0)
        
        // When
        let cell = try XCTUnwrap(sut).collectionView(
            testCollectionView,
            cellForItemAt: indexPath
        )
        
        // Then
        XCTAssertTrue(cell is EmptyArticlesCell)
    }
    
    func test_collectionView_shouldReturnCorrectNumberOfItems() throws {
        // Given
        let testArticles = [
            DisplayedArticle(id: 1, title: "Test 1", description: "Desc 1",
                             publishDate: "Jan 1", imageUrl: nil,
                             authorName: "Author 1", tags: "tag1"),
            DisplayedArticle(id: 2, title: "Test 2", description: "Desc 2",
                             publishDate: "Jan 2", imageUrl: nil,
                             authorName: "Author 2", tags: "tag2")
        ]
        dataStoreSpy?.displayedArticles = testArticles
        
        // When
        let numberOfItems = try XCTUnwrap(sut).collectionView(
            testCollectionView,
            numberOfItemsInSection: 0
        )
        
        // Then
        XCTAssertEqual(numberOfItems, testArticles.count)
    }
    
    // MARK: - Test Setup
    private func setupTestComponents() throws {
        interactorSpy = ArticlesInteractorSpy()
        dataStoreSpy = ArticlesDataStoreSpy()
        sut = ArticlesViewController(interactor: try XCTUnwrap(interactorSpy))
        sut?.dataStore = try XCTUnwrap(dataStoreSpy)
        sut?.loadViewIfNeeded()
    }
    
    private func cleanUpTestComponents() {
        sut = nil
        interactorSpy?.reset()
        interactorSpy = nil
        dataStoreSpy = nil
    }
}
