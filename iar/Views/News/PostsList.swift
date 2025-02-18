//
//  PostsList.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI

struct PostsList: View {
    
    @ObservedObject var viewModel: NewsViewModel
    @State private var showingSpecial: Bool = false
    @State private var isVisible: Bool = false
    
    var body: some View {
        mainContent
            .refreshable {
                await viewModel.refreshNews()
            }
    }
    
    var mainContent: some View {
        List {
            Section {
                if let special = viewModel.announcements?.special {
                    specialButton(special: special)
                        .listRowSeparator(.hidden)
                }
                
                if let featured = viewModel.announcements?.featured {
                    NavigationLink(destination: WebView(featured)) {
                        PostRow(post: featured)
                    }
                }
                
                ForEach(viewModel.announcements?.posts ?? []) { post in
                    NavigationLink(destination: WebView(post)) {
                        PostRow(post: post)
                    }
                }
            }
            .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
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
        .sheet(isPresented: $showingSpecial) {
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
    
    func specialButton(special: Post) -> some View {
        Button {
            showingSpecial = true
        } label: {
            SpecialHeader(special: special)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#if DEBUG
#Preview {
    let newsViewModel = NewsViewModel(provider: MockProvider())
    PostsList(viewModel: newsViewModel)
        .onAppear {
            newsViewModel.fetchLatest()
        }
}
#endif
