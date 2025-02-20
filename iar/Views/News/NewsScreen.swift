//
//  NewsScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct NewsScreen: View {

    @ObservedObject var viewModel: NewsViewModel
    @State var section: NewsSection = .announcements

    var body: some View {
        PostsList(viewModel: viewModel)
        .toolbar {
            if (viewModel.loading) {
                ProgressView()
            }
        }
    }
}

#if DEBUG
#Preview {
    let vm = NewsViewModel(provider: MockProvider())
    NavigationView {
        NewsScreen(viewModel: vm)
            .navigationTitle("News")
            .onAppear {
                vm.loadData()
            }
    }
}
#endif
