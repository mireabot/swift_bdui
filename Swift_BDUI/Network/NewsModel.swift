//
//  NewsModel.swift
//  Swift_BDUI
//
//  Created by Mikhail Kolkov on 1/27/25.
//

import Foundation

struct NewsResult: Codable {
    var articles: [Article]
    let title: String?
}

struct Article: Codable, Hashable {
    var author: String?
    var source: ArticleSource?
    var urlToImage: String?
    var publishedAt: String?
    var title: String?
}

struct ArticleSource: Codable, Hashable {
    var id: String?
    var name: String?
}

