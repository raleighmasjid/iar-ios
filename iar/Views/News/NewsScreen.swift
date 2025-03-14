//
//  NewsScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct NewsScreen: View {

    @ObservedObject var viewModel: NewsViewModel
    @Binding var path: [Post]
    @State private var showingSpecial: Bool = false
    @State private var isVisible: Bool = false

    var body: some View {
        PostsList(announcements: viewModel.announcements, path: $path)
        .toolbar {
            if (viewModel.loading) {
                ProgressView()
            }
        }
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
        .onChange(of: viewModel.announcements) { newAnnouncement in
            if isVisible {
                viewModel.didViewAnnouncements()
            }
        }
        .navigationDestination(for: Post.self) { post in
            WebView(post)
        }
        .fullScreenCover(isPresented: $showingSpecial) {
            NavigationView {
                if let special = viewModel.announcements?.special {
                    WebView(special, done: {
                        showingSpecial = false
                    })
                    .navigationBarTitleDisplayMode(.inline)
                    .ignoresSafeArea(.all, edges: .bottom)
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    let vm = NewsViewModel(provider: MockProvider())
    NavigationView {
        NewsScreen(viewModel: vm, path: .constant([]))
            .navigationTitle("News")
            .onAppear {
                vm.loadData()
            }
    }
}
#endif
