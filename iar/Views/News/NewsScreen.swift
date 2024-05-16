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
struct NewsScreen_Previews: PreviewProvider {
    static let vm: NewsViewModel = {
       let v = NewsViewModel(provider: MockProvider())
        v.fetchLatest()
        return v
    }()
    static var previews: some View {
        NavigationView {
            NewsScreen(viewModel: vm)
                .navigationTitle("News")
        }
    }
}
#endif
