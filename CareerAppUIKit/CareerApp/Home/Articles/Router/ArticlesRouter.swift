//
//  ArticlesRouter.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

import Foundation

// MARK: - Router

protocol ArticlesRoutingLogic {
    // Potencial navegação para detalhes do artigo
}

protocol ArticlesDataStore {
    var articles: [Article]? { get set }
}

class ArticlesRouter: NSObject, ArticlesRoutingLogic, ArticlesDataStore {
    var articles: [Article]?
    
    weak var viewController: ArticlesViewController?
    var dataStore: ArticlesDataStore?
    
    // Implementar navegação se necessário
}
