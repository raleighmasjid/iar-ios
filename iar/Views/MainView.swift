//
//  MainView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: PrayerTimesViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                PrayerHeader(prayerDay: viewModel.current,
                             upcoming: viewModel.upcoming,
                             remaining: viewModel.timeRemaining)
                PrayerView(prayerDay: viewModel.current,
                           alarmSetting: viewModel.alarm)
                Spacer(minLength: 10)
            }
            .onAppear {
                if viewModel.current == nil {
                    viewModel.loadTimes()
                }
            }
            .navigationTitle("Prayer Times")
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
//        MainView(viewModel: PrayerTimesViewModel(provider: MockProvider()))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
//            .previewDisplayName("iPhone 13")
        MainView(viewModel: PrayerTimesViewModel(provider: MockProvider()))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
//        MainView(viewModel: PrayerTimesViewModel(provider: MockProvider()))
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (1st generation)"))
//            .previewDisplayName("iPhone SE")
    }
}
#endif
