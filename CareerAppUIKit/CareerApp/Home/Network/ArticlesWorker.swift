//
//  ArticlesWorker.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

import Foundation

// MARK: - Worker

protocol ArticlesWorkerProtocol {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
}

class ArticlesWorker: ArticlesWorkerProtocol {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: "https://dev.to/api/articles") else {
            print("❌ Invalid URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        print("🌐 Starting request to: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("🔵 DataTask completion handler called")
            
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("❌ No data received")
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let articles = try JSONDecoder().decode([Article].self, from: data)
                print("✅ Success! Articles fetched: \(articles.count)")
                completion(.success(articles))
            } catch {
                print("❌ Decoding error: \(error)")
                completion(.failure(error))
            }
            
        }.resume()
        print("🚀 Task resumed")
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
