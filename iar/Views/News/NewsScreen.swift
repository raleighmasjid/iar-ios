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
        VStack {
            Picker("Section", selection: $section) {
                ForEach(NewsSection.allCases) {
                    Text($0.title).tag($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .zIndex(1) // workaround for deselection bug in iOS 14

            switch (section) {
            case .announcements:
                PostsList(viewModel: viewModel)
            case .events:
                EventsList(viewModel: viewModel)
            }
        }
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
        NewsScreen(viewModel: vm)
    }
}
#endif
