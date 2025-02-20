//
//  NewsViewModel.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/8/22.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var announcements: Announcements?
    
    @Published var badge: String?
    
    @Published var error = false
    @Published var loading = false
    
    @StoredDefault(key: .viewedAnnouncements, defaultValue: [])
    private var viewedAnnouncements: [Int]
    
    private let provider: NewsProvider

    init(provider: NewsProvider) {
        self.provider = provider
    }
    
    func loadData() {
        loading = true
        Task {
            do {
                let news = try await self.provider.fetchNews(forceRefresh: true)
                self.didFetchNews(news: news)
                self.loading = false
            } catch {
                self.error = true
                self.loading = false
            }
        }
    }
    
    func refreshNews() async {
        do {
            let news = try await provider.fetchNews(forceRefresh: true)
            self.didFetchNews(news: news)
        } catch {
            self.error = true
        }
    }
    
    func didViewAnnouncements() {
        if let announcements = announcements {
            let postIDs = announcements.postIDs()
            viewedAnnouncements = postIDs

            updateBadge()
        }
    }
    
    private func didFetchNews(news: News) {
        announcements = news.announcements
        updateBadge()
    }
    
    private func updateBadge() {
        guard let announcements = announcements else {
            badge = nil
            return
        }

        let currentIds = Set(announcements.postIDs())
        let viewedIds = Set(viewedAnnouncements)
        
        let unviewedIds = currentIds.subtracting(viewedIds)
        badge = unviewedIds.isEmpty ? nil : " "
    }
}
