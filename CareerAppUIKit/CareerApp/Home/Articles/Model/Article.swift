//
//  Article.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

// MARK: - Models

struct Article: Codable {
    let id: Int
    let title: String
    let description: String
    let readablePublishDate: String
    let url: String
    let coverImage: String?
    let tags: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, url, tags, user
        case readablePublishDate = "readable_publish_date"
        case coverImage = "cover_image"
    }
}

struct User: Codable {
    let name: String
    let username: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case name, username
        case profileImage = "profile_image"
    }
}

enum Articles {
    struct FetchArticles {
        struct Request { }
        
        struct Response {
            let articles: [Article]
            let error: Error?
        }
        
        struct ViewModel {
            struct DisplayedArticle {
                let title: String
                let description: String
                let publishDate: String
                let imageUrl: String?
                let authorName: String
                let tags: String
            }
            
            let displayedArticles: [DisplayedArticle]
        }
    }
}
