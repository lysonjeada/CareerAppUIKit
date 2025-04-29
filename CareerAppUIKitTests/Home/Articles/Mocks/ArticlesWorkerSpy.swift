//
//  ArticlesWorkerSpy.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 28/04/25.
//

@testable import CareerAppUIKit

final class ArticlesWorkerSpy: ArticlesWorkerProtocol {
    
    // MARK: - Properties
    private var stubbedArticles: [Article] = []
    private var stubbedError: Error?
    
    // MARK: - Public Methods
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        if let error = stubbedError {
            completion(.failure(error))
        } else {
            completion(.success(stubbedArticles))
        }
    }
    
    // MARK: - Stub Methods
    func stubSuccessResponse(with articles: [Article]) {
        stubbedArticles = articles
        stubbedError = nil
    }
    
    func stubFailureResponse(with error: Error) {
        stubbedError = error
        stubbedArticles = []
    }
    
    func reset() {
        stubbedArticles = []
        stubbedError = nil
    }
}
