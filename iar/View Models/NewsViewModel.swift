//
//  NewsViewModel.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/8/22.
//

import Foundation
import UIKit

@MainActor
class NewsViewModel: ObservableObject {
    @Published var announcements: Announcements?
    
    @Published var badge: Bool = false
    
    @Published var error = false
    @Published var loading = false
    
    @StoredDefault(key: .viewedAnnouncements, defaultValue: [])
    private var viewedAnnouncements: [Int]
    
    private let provider: NewsProvider
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid

    init(provider: NewsProvider) {
        self.provider = provider
    }
    
    func loadData() {
        loading = true
        if let cache = provider.cachedNews {
            didFetchNews(news: cache)
        }
        Task {
            do {
                let news = try await self.provider.fetchNews(forceRefresh: false)
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
            startBackgroundTask()
            let news = try await provider.fetchNews(forceRefresh: true)
            self.didFetchNews(news: news)
            endBackgroundTask()
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
            badge = false
            return
        }

        let currentIds = Set(announcements.postIDs())
        let viewedIds = Set(viewedAnnouncements)
        
        let unviewedIds = currentIds.subtracting(viewedIds)
        badge = !unviewedIds.isEmpty
    }
    
    private func startBackgroundTask() {
        if backgroundTask == .invalid {
            backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
                self?.endBackgroundTask()
            }
        }
    }

    private func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
}
