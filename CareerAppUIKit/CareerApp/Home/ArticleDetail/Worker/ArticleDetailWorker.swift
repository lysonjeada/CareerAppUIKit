//
//  ArticleDetailWorker.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 14/04/25.
//

import Foundation

protocol ArticleDetailWorkerProtocol {
    func fetchArticleDetail(id: Int, completion: @escaping (Result<ArticleDetail, Error>) -> Void)
}

class ArticleDetailWorker: ArticleDetailWorkerProtocol  {
    func fetchArticleDetail(id: Int, completion: @escaping (Result<ArticleDetail, Error>) -> Void) {
        let urlString = "https://dev.to/api/articles/\(id)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let articleDetail = try decoder.decode(ArticleDetail.self, from: data)
                completion(.success(articleDetail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
