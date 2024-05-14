//
//  PrayerScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI

struct PrayerScreen: View {
    @ObservedObject var viewModel: PrayerTimesViewModel
    @State var scrollPosition = 0.0
    let scrollNamespace = "PrayerScrollView"
    
    var stickyHeaderOpacity: Double {
        scrollPosition < -64 ? 1 : 0
    }
    
    var largeHeaderOpacity: Double {
        scrollPosition >= -64 ? 1 : 0
    }
    
    var headerHeight: Double {
        max(0, 278 + scrollPosition)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(.prayerHeader)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: headerHeight, alignment: .top)
                .frame(maxWidth: UIScreen.main.bounds.width)
                .clipped()
                .allowsHitTesting(false)
            
            ScrollView {
            
                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        PrayerCountdown(upcoming: viewModel.upcoming)
                            .frame(height: 240)
                            .opacity(largeHeaderOpacity)
                        HStack {
                            Spacer(minLength: 50)
                            if viewModel.loading {
                                ProgressView()
                                    .padding(.trailing, 24)
                            }
                        }
                    }
                    PrayerTimesView(prayerDays: viewModel.prayerDays)
                    FridayScheduleView(fridayPrayers: viewModel.fridaySchedule)
                    Spacer(minLength: 5)
                }
            
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(key: PrayerScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named(scrollNamespace)).origin)
                })
                .onPreferenceChange(PrayerScrollOffsetPreferenceKey.self) { value in
                    self.scrollPosition = value.y
                }
            }
            .coordinateSpace(name: scrollNamespace)
        }
        
        .ignoresSafeArea(edges: .top)
        .background(Color.prayerScreenBackground)
        .alert(isPresented: $viewModel.error) {
            Alert(title: Text("Error"),
                  message: Text("Unable to load prayer times"),
                  primaryButton: .default(Text("Retry"),
                                          action: { viewModel.fetchLatest() }),
                  secondaryButton: .cancel(Text("Dismiss")))
        }
        .overlay(alignment: .top) {
            ZStack(alignment: .top) {
                    Image(.prayerHeader)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 100, alignment: .top)
                        .frame(maxWidth: .infinity)
                        .clipped()
                Text("Asr is in 12hrs 49min")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.top, 60)
            }
            .ignoresSafeArea(edges: .top)
//            .padding(.bottom, 20)
            .frame(maxWidth: .infinity)
            .opacity(stickyHeaderOpacity)
            .allowsHitTesting(false)
            
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
            .environmentObject(viewModel.notificationSettings)
        
//        PrayerScreen(viewModel: PrayerTimesViewModel(provider: MockProvider()))
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (1st generation)"))
//            .previewDisplayName("iPhone SE")
//            .environmentObject(viewModel.notificationSettings)
    }
}
#endif
