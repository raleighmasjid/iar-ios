//
//  PrayerScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI

struct PrayerScreen: View {

    @ObservedObject var viewModel: PrayerTimesViewModel

    @State var contentArea: CGRect = .zero
    @State var countdownFrame: CGRect = .zero
    @State var smallCountdownHeight: CGFloat = 0
    @State var countdownTextHeight: CGFloat = 0
    private let scrollNamespace = "PrayerScrollView"
    
    let smallCountdownVerticalPadding: CGFloat = 8.0
    
    var countdownMode: PrayerCountdown.Mode {
        contentArea.size.height >= 650 ? .large : .small
    }
    
    var scrollPosition: CGFloat {
        countdownFrame.origin.y
    }
    
    func opacityMetrics() -> (start: CGFloat, end: CGFloat, duration: CGFloat) {
        let end: CGFloat = (smallCountdownHeight - smallCountdownVerticalPadding) - (countdownFrame.height - countdownMode.verticalPadding)
        let duration: CGFloat = countdownTextHeight - (smallCountdownHeight - (smallCountdownVerticalPadding * 2))
        let start: CGFloat = end + duration
        return (start: start, end: end, duration: duration)
    }
    
    func stickyOpacityMetrics() -> (start: CGFloat, end: CGFloat, duration: CGFloat) {
        let metrics = opacityMetrics()
        let offset = smallCountdownVerticalPadding / 2
        let end = max(metrics.end - offset, smallCountdownHeight - countdownFrame.height)
        let start = metrics.end + offset
        let duration = start - end
        return (start: start, end: end, duration: duration)
    }
    
    var stickyHeaderOpacity: Double {
        let metrics = stickyOpacityMetrics()
        
        switch scrollPosition {
        case _ where scrollPosition > metrics.start:
            return 0
        case _ where scrollPosition <= metrics.end:
            return 1
        default:
            return 1.0 - abs((scrollPosition - metrics.end) / metrics.duration)
        }
    }
    
    var largeHeaderOpacity: Double {
        let metrics = opacityMetrics()
        
        switch scrollPosition {
        case _ where scrollPosition >= metrics.start:
            return 1
        case _ where scrollPosition < metrics.end:
            return 0
        default:
            return abs((scrollPosition - metrics.end) / metrics.duration)
        }
    }
    
    var headerHeight: CGFloat {
        max(0, countdownFrame.size.height + contentArea.origin.y + countdownFrame.origin.y + 38)
    }

    var headerImage: some View {
        Image(.prayerHeader)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: headerHeight, alignment: .top)
            .clipped()
            .allowsHitTesting(false)
            .ignoresSafeArea(edges: .top)
    }
    
    var statusBarImage: some View {
        Image(.prayerHeader)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: min(UIApplication.shared.statusBarHeight, 30), alignment: .top)
            .clipped()
            .allowsHitTesting(false)
            .ignoresSafeArea(edges: .top)
    }

    var countdownView: some View {
        PrayerCountdown(upcoming: viewModel.upcoming,
                        mode: countdownMode,
                        textHeight: $countdownTextHeight)
            .opacity(largeHeaderOpacity)
            .frame(maxWidth: .infinity)
    }

    var stickyHeader: some View {
        SmallPrayerCountdown(upcoming: viewModel.upcoming,
                             verticalPadding: smallCountdownVerticalPadding,
                             safeArea: contentArea.origin.y,
                             textHeight: $smallCountdownHeight)
            .frame(maxWidth: .infinity)
            .opacity(stickyHeaderOpacity)
            .allowsHitTesting(false)
    }

    var body: some View {
        ZStack(alignment: .top) {
            headerImage
                .frame(maxWidth: contentArea.size.width)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    countdownView
                        .onGeometryChange(for: CGRect.self) { proxy in
                            proxy.frame(in: .named(scrollNamespace))
                        } action: { value in
                            self.countdownFrame = value
                        }
                    PrayerTimesView(prayerDays: viewModel.prayerDays)
                    FridayScheduleView(fridayPrayers: viewModel.fridaySchedule)
                    Spacer(minLength: 5)
                }
            }
            .coordinateSpace(name: scrollNamespace)
            .scrollIndicators(.hidden)
            .targetedScrollView(
                transitionStart: opacityMetrics().start * -1,
                transitionEnd: stickyOpacityMetrics().end * -1)

            statusBarImage
            
            HStack {
                Spacer(minLength: 50)
                if viewModel.loading {
                    ProgressView()
                        .tint(.white)
                        .padding(.trailing, 42)
                        .padding(.top, 8)
                }
            }
        }
        .background(.surfaceVariant)
        .alert(isPresented: $viewModel.error) {
            Alert(title: Text("Error"),
                  message: Text("Unable to load prayer times"),
                  primaryButton: .default(Text("Retry"),
                                          action: { viewModel.loadData() }),
                  secondaryButton: .cancel(Text("Dismiss")))
        }
        .overlay(alignment: .top) {
            stickyHeader
        }.onGeometryChange(for: CGRect.self) { proxy in
            CGRect(x: 0, y: proxy.safeAreaInsets.top, width: proxy.size.width, height: proxy.size.height)
        } action: { newValue in
            contentArea = newValue
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
