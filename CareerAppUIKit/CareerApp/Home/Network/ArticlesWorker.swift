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
            print("❌ URL inválida")
            completion(.failure(NetworkError.invalidURL))
            return
        }
        print("🌐 Iniciando requisição para: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("🔵 DataTask completion handler chamado")
            
            if let error = error {
                print("❌ Erro: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("❌ Nenhum dado recebido")
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let articles = try JSONDecoder().decode([Article].self, from: data)
                print("✅ Success! Artigos carregados: \(articles.count)")
                completion(.success(articles))
            } catch {
                print("❌ Erro de decode: \(error)")
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
