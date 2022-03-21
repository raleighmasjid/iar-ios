//
//  EventList.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI

struct EventList: View {
    
    @ObservedObject var viewModel: NewsViewModel
    
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
            ForEach(viewModel.events.keys.sorted(), id: \.self) { date in
                let events = viewModel.events[date]?.sorted(comparingKeyPath: \.start) ?? []
                if #available(iOS 15.0, *) {
                    eventSection(date: date, events: events)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 6, leading: 20, bottom: 0, trailing: 20))
                } else {
                    eventSection(date: date, events: events)
                        .textCase(nil)
                }
            }
        }
        .listStyle(.plain)
    }
    
    func eventSection(date: Date, events: [Event]) -> some View {
        Section {
            ForEach(events) { event in
                NavigationLink(destination: WebView(event)) {
                    EventRow(event: event)
                }
            }
        } header: {
            Text(Formatter.dayFormatter.string(from: date))
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(.primary)
        }
    }
}

#if DEBUG
struct EventList_Previews: PreviewProvider {
    static let vm: NewsViewModel = {
       let v = NewsViewModel(provider: MockProvider())
        v.fetchLatest()
        return v
    }()
    static var previews: some View {
        EventList(viewModel: vm)
    }
}
#endif
