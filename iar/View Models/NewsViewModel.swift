//
//  NewsViewModel.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/8/22.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var announcements: [Announcement] = []
    @Published var events: [Date: [Event]] = [:]
    @Published var special: SpecialAnnouncement?
    
    @Published var badge: String?
    
    @Published var error = false
    @Published var loading = false
    
    @StoredDefault(key: .viewedSpecial, defaultValue: 0)
    var viewedSpecial: Int {
        didSet {
            updateBadge()
        }
    }
    
    private let provider: NewsProvider

    init(provider: NewsProvider) {
        self.provider = provider
    }
    
    func fetchLatest() {
        if let cached = provider.cachedNews {
            didFetchNews(news: cached)
        }

        loading = true
        Task {
            await refreshNews()
            self.loading = false
        }
    }
    
    @MainActor
    func refreshNews() async {
        do {
            let news = try await provider.fetchNews()
            self.didFetchNews(news: news)
        } catch {
            NSLog("Error \(error)")
            self.error = true
        }
    }
    
    func didFetchNews(news: News) {
        announcements = news.announcements
        let cal = Calendar.current
        events = Dictionary(grouping: news.events, by: { cal.startOfDay(for: $0.start) })
        special = news.special
        updateBadge()
    }
    
    private func updateBadge() {
        if let special = special, special.id != viewedSpecial {
            badge = " "
        } else {
            badge = nil
        }
    }
}
