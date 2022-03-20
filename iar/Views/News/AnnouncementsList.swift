//
//  AnnouncementsList.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI

struct AnnouncementsList: View {
    
    @ObservedObject var viewModel: NewsViewModel
    @State private var showingSpecial: Bool = false
    @State private var isVisible: Bool = false
    
    var body: some View {
        if #available(iOS 15.0, *) {
            mainContent
                .refreshable {
                    await viewModel.refreshNews()
                }
        } else {
            mainContent
        }
    }
    
    var mainContent: some View {
        List {
            if let special = viewModel.announcements?.special {
                if #available(iOS 15.0, *) {
                    specialButton(special: special)
                        .listRowSeparator(.hidden)
                } else {
                    specialButton(special: special)
                }
            }
            
            if let featured = viewModel.announcements?.featured {
                NavigationLink(destination: WebView(featured)) {
                    AnnouncementRow(announcement: featured)
                }
            }
            
            ForEach(viewModel.announcements?.posts ?? []) { post in
                NavigationLink(destination: WebView(post)) {
                    AnnouncementRow(announcement: post)
                }
            }
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
struct AnnouncementsList_Previews: PreviewProvider {
    static let vm: NewsViewModel = {
       let v = NewsViewModel(provider: MockProvider())
        v.fetchLatest()
        return v
    }()
    static var previews: some View {
        AnnouncementsList(viewModel: vm)
    }
}
#endif
