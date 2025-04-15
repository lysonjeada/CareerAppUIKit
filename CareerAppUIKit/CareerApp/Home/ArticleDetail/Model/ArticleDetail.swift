//
//  ArticleDetail.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 14/04/25.
//

import Foundation

struct ArticleDetail: Codable {
    let typeOf: String?
    let id: Int?
    let title: String?
    let description: String?
    let readablePublishDate: String?
    let slug: String?
    let path: String?
    let url: String?
    let commentsCount: Int?
    let publicReactionsCount: Int?
    let collectionId: Int?
    let publishedTimestamp: String?
    let language: String?
    let subforemId: Int?
    let positiveReactionsCount: Int?
    let coverImage: String?
    let socialImage: String?
    let canonicalUrl: String?
    let createdAt: String?
    let editedAt: String?
    let crosspostedAt: String?
    let publishedAt: String?
    let lastCommentAt: String?
    let readingTimeMinutes: Int?
    let tagList: String?
    let tags: [String]?
    let bodyHtml: String?
    let bodyMarkdown: String?
    let user: UserDetail?
    let organization: Organization?
    
    enum CodingKeys: String, CodingKey {
        case typeOf = "type_of"
        case id
        case title
        case description
        case readablePublishDate = "readable_publish_date"
        case slug
        case path
        case url
        case commentsCount = "comments_count"
        case publicReactionsCount = "public_reactions_count"
        case collectionId = "collection_id"
        case publishedTimestamp = "published_timestamp"
        case language
        case subforemId = "subforem_id"
        case positiveReactionsCount = "positive_reactions_count"
        case coverImage = "cover_image"
        case socialImage = "social_image"
        case canonicalUrl = "canonical_url"
        case createdAt = "created_at"
        case editedAt = "edited_at"
        case crosspostedAt = "crossposted_at"
        case publishedAt = "published_at"
        case lastCommentAt = "last_comment_at"
        case readingTimeMinutes = "reading_time_minutes"
        case tagList = "tag_list"
        case tags
        case bodyHtml = "body_html"
        case bodyMarkdown = "body_markdown"
        case user
        case organization
    }
}

struct UserDetail: Codable {
    let name: String?
    let username: String?
    let twitterUsername: String?
    let githubUsername: String?
    let userId: Int?
    let websiteUrl: String?
    let profileImage: String?
    let profileImage90: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case twitterUsername = "twitter_username"
        case githubUsername = "github_username"
        case userId = "user_id"
        case websiteUrl = "website_url"
        case profileImage = "profile_image"
        case profileImage90 = "profile_image_90"
    }
}

struct Organization: Codable {
    let name: String?
    let username: String?
    let slug: String?
    let profileImage: String?
    let profileImage90: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case slug
        case profileImage = "profile_image"
        case profileImage90 = "profile_image_90"
    }
}

enum ArticlesDetail {
    enum FetchArticle {
        struct Request {
            let articleId: Int
        }
        
        struct Response {
            let articleDetail: ArticleDetail?
            let error: Error?
        }
        
        struct ViewModel {
            let displayedArticleDetail: DisplayedArticleDetail
        }
    }
    
    struct DisplayedArticleDetail {
        let title: String
        let description: String
        let coverImageURL: String?
        let readablePublishDate: String
        let readingTimeMinutes: Int
        let bodyHtml: String
        let authorName: String
        let authorProfileImage: String?
    }
}
