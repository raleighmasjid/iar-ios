//
//  PrayerScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI

struct PrayerScreen: View {
    @ObservedObject var viewModel: PrayerTimesViewModel
    @State var dayOffset = 0
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ScrollView {
            Spacer().frame(height: 16)
            VStack(alignment: .leading, spacing: 0) {
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
                FridayScheduleView(fridayPrayers: viewModel.fridaySchedule)
                Spacer(minLength: 5)
            }
        }
        .background(Color.prayerScreenBackground)
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background:
                dayOffset = 0
            default:
                break
            }
        }
        .onChange(of: viewModel.prayerDays) { newValue in
            if newValue.count <= dayOffset {
                dayOffset = 0
            }
        }
        .alert(isPresented: $viewModel.error) {
            Alert(title: Text("Error"),
                  message: Text("Unable to load prayer times"),
                  primaryButton: .default(Text("Retry"),
                                          action: { viewModel.fetchLatest() }),
                  secondaryButton: .cancel(Text("Dismiss")))
        }
    }
    

}

#if DEBUG
struct PrayerScreen_Previews: PreviewProvider {
    static let viewModel = PrayerTimesViewModel(provider: MockProvider())
    static var previews: some View {
//        PrayerScreen(viewModel: viewModel)
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
//            .previewDisplayName("iPhone 13")
//            .environmentObject(viewModel.notificationSettings)
        
        PrayerScreen(viewModel: PrayerTimesViewModel(provider: MockProvider()))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
            .environmentObject(viewModel.notificationSettings)
        
//        PrayerScreen(viewModel: PrayerTimesViewModel(provider: MockProvider()))
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (1st generation)"))
//            .previewDisplayName("iPhone SE")
//            .environmentObject(viewModel.notificationSettings)
    }
}
#endif
