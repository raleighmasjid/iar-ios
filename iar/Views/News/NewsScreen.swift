//
//  NewsScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct NewsScreen: View {

    @ObservedObject var viewModel: NewsViewModel
    @State var path: [Post] = []
    @State private var isVisible: Bool = false

    var body: some View {
        NavigationStack(path: $path) {
            PostsList(announcements: viewModel.announcements, path: $path)
                .toolbar {
                    if (viewModel.loading) {
                        ProgressView()
                    }
                }
                .toolbarTitleDisplayMode(.inlineLarge)
                .navigationTitle("News")
                .background(.appBackground)
                .refreshable {
                    await viewModel.refreshNews()
                }
                .onAppear {
                    isVisible = true
                    viewModel.didViewAnnouncements()
                }
                .onDisappear {
                    isVisible = false
                }
                .onChange(of: viewModel.announcements) { _, newAnnouncement in
                    if isVisible {
                        viewModel.didViewAnnouncements()
                    }
                }
                .navigationDestination(for: Post.self) { post in
                    WebView(post)
                }
        }
    }
}

#if DEBUG
#Preview {
    let vm = NewsViewModel(provider: MockProvider())
    NavigationView {
        NewsScreen(viewModel: vm)
            .onAppear {
                vm.loadData()
            }
    }
}
#endif
