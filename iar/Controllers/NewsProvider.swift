//
//  NewsProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/8/22.
//

import Foundation
import Combine

protocol NewsProvider: AnyObject {
    var cachedNews: News? { get }
    func fetchNews() async throws -> News
}

class NetworkNewsProvider: NewsProvider {
    let session = URLSession.shared

    @StoredDefault(key: .newsCache, defaultValue: nil)
    private(set) var cachedNews: News?

    @MainActor
    func fetchNews() async throws -> News {
        let (data, _) = try await session.data(from: "https://raleighmasjid.org/API/app/news/")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let news = try decoder.decode(News.self, from: data)
        cachedNews = news
        return news
    }
}
