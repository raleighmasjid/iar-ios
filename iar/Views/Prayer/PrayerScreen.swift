//
//  PrayerScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI

struct PrayerScreen: View {
    @Environment(\.scenePhase) var scenePhase
    let dayChange = NotificationCenter.default.publisher(for: .NSCalendarDayChanged)
    @StateObject var viewModel: PrayerTimesViewModel
    @State var dayOffset = 0
    @State var didEnterBackground = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack {
                        PrayerCountdown(upcoming: viewModel.upcoming)
                        HStack {
                            Spacer(minLength: 50)
                            if viewModel.loading {
                                ProgressView()
                                    .padding(.trailing, 24)
                            }
                        }
                    }
                    PrayerHeader(prayerDays: viewModel.prayerDays, dayOffset: $dayOffset)
                    PrayerTimesView(prayerDays: viewModel.prayerDays, dayOffset: $dayOffset)
                    Spacer(minLength: 10)
                }
            }
            .onAppear {
                if viewModel.prayerDays.isEmpty {
                    viewModel.fetchLatest()
                }
            }
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .background:
                    didEnterBackground = true
                case .active:
                    if didEnterBackground {
                        didEnterBackground = false
                        dayOffset = 0
                        viewModel.fetchLatest()
                    }
                default:
                    break
                }
            }
            .onChange(of: viewModel.prayerDays) { newValue in
                if newValue.count <= dayOffset {
                    dayOffset = 0
                }
            }
            .onReceive(dayChange) { _ in
                viewModel.fetchLatest()
            }
            .navigationTitle("Prayer Times")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $viewModel.error) {
                Alert(title: Text("Error"),
                      message: Text("Unable to load prayer times"),
                      primaryButton: .default(Text("Retry"),
                                              action: { viewModel.fetchLatest() }),
                      secondaryButton: .cancel(Text("Dismiss")))
            }
        }
    }
    

}

#if DEBUG
struct PrayerScreen_Previews: PreviewProvider {
    static let viewModel = PrayerTimesViewModel(provider: MockProvider())
    static var previews: some View {
        PrayerScreen(viewModel: viewModel)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
            .previewDisplayName("iPhone 13")
            .environmentObject(viewModel.notificationSettings)
        
//        PrayerScreen(viewModel: PrayerTimesViewModel(provider: MockProvider()))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//            .previewDisplayName("iPhone 8")
//            .environmentObject(viewModel.notificationSettings)
        
//        PrayerScreen(viewModel: PrayerTimesViewModel(provider: MockProvider()))
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (1st generation)"))
//            .previewDisplayName("iPhone SE")
//            .environmentObject(viewModel.notificationSettings)
    }
}
#endif
