//
//  ArticlesDataStore.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 26/04/25.
//

protocol ArticlesDataStoreProtocol: AnyObject {
    var displayedArticles: [DisplayedArticle] { get set }
}

final class ArticlesDataStore: ArticlesDataStoreProtocol {
    var displayedArticles: [DisplayedArticle] = []
}
