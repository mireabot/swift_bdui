//
//  RepositoryManager.swift
//  Swift_BDUI
//
//  Created by Mikhail Kolkov on 1/27/25.
//

import Foundation
import RxSwift
import Alamofire

// Get API key from https://newsapi.org/
let apiKey = "your-api-key"

protocol TmdbRepository {

    func getCountryBreakingNews() -> Observable<NewsResult>

    func getNewsBySource(source: String) -> Observable<NewsResult>

    func getNewsByKeyword(keyword: String) -> Observable<NewsResult>
}

class TmDbRepositoryImpl : BaseRepository, TmdbRepository {

    func getCountryBreakingNews() -> Observable<NewsResult> {
        return super.createRequest(url: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(apiKey)")
    }

    func getNewsBySource(source: String) -> Observable<NewsResult> {
        super.createRequest(url: "https://newsapi.org/v2/top-headlines?sources=\(source)&apiKey=\(apiKey)")
    }

    func getNewsByKeyword(keyword: String) -> Observable<NewsResult> {
        return super.createRequest(url: "https://newsapi.org/v2/everything?q=\(keyword)&apiKey=\(apiKey)")
    }
}

