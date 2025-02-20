//
//  PrayerScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI

struct PrayerScreen: View {
    @ObservedObject var viewModel: PrayerTimesViewModel

    @State private var scrollPosition = 0.0
    @Environment(\.safeAreaInsets) private var safeArea
    private let scrollNamespace = "PrayerScrollView"
    
    var stickyHeaderOpacity: Double {
        switch scrollPosition {
        case _ where scrollPosition <= (-1 * safeArea.top) - 50:
            return 1
        case _ where scrollPosition > (-1 * safeArea.top) - 35:
            return 0
        default:
            return abs((scrollPosition + safeArea.top + 35.0) / 15.0)
        }
    }
    
    var largeHeaderOpacity: Double {
        switch scrollPosition {
        case _ where scrollPosition >= (-1 * safeArea.top):
            return 1
        case _ where scrollPosition < (-1 * safeArea.top) - 40:
            return 0
        default:
            return 1 - abs((scrollPosition + safeArea.top) / 40.0)
        }
    }
    
    var headerHeight: CGFloat {
        max(0, countdownHeight + 38 + scrollPosition)
    }
    
    var contentAreaHeight: CGFloat {
        UIScreen.main.bounds.height - (safeArea.top + safeArea.bottom)
    }
    
    var countdownHeight: CGFloat {
        let addedHeight: CGFloat = contentAreaHeight > 650 ? 180 : 130
        return safeArea.top + addedHeight
    }

    var headerImage: some View {
        Image(.prayerHeader)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: headerHeight, alignment: .top)
            .frame(maxWidth: UIScreen.main.bounds.width)
            .clipped()
            .allowsHitTesting(false)
    }

    var countdownView: some View {
        ZStack(alignment: .top) {
            PrayerCountdown(upcoming: viewModel.upcoming)
                .frame(height: countdownHeight)
                .opacity(largeHeaderOpacity)
            HStack {
                Spacer(minLength: 50)
                if viewModel.loading {
                    ProgressView()
                        .tint(.white)
                        .padding(.trailing, 48)
                        .padding(.top, safeArea.top + 12)
                }
            }
        }
    }

    var stickyHeader: some View {
        SmallPrayerCountdown(upcoming: viewModel.upcoming)
            .ignoresSafeArea(edges: .top)
            .frame(maxWidth: .infinity)
            .opacity(stickyHeaderOpacity)
            .allowsHitTesting(false)
    }

    var body: some View {
        ZStack(alignment: .top) {
            headerImage

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    countdownView
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
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea(edges: .top)
        .background(Color.prayerScreenBackground)
        .alert(isPresented: $viewModel.error) {
            Alert(title: Text("Error"),
                  message: Text("Unable to load prayer times"),
                  primaryButton: .default(Text("Retry"),
                                          action: { viewModel.loadData() }),
                  secondaryButton: .cancel(Text("Dismiss")))
        }
        .overlay(alignment: .top) {
            stickyHeader
        }
    }
}

#if DEBUG
#Preview {
    let viewModel = PrayerTimesViewModel(provider: MockProvider())
    PrayerScreen(viewModel: viewModel)
        .environmentObject(viewModel.notificationSettings)
        .onAppear {
            viewModel.loadData()
        }
}
#endif
