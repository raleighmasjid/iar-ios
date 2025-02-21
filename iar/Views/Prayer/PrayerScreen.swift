//
//  PrayerScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI

struct PrayerScreen: View {

    @ObservedObject var viewModel: PrayerTimesViewModel

    @State var safeArea: CGSize = .zero
    @State var countdownFrame: CGRect = .zero
    @State var smallCountdownHeight: CGFloat = 0
    @State var countdownTextHeight: CGFloat = 0
    private let scrollNamespace = "PrayerScrollView"
    
    let smallCountdownVerticalPadding: CGFloat = 18.0
    let countdownVerticalPadding: CGFloat = 40.0
    
    var scrollPosition: CGFloat {
        countdownFrame.origin.y
    }
    
    var stickyHeaderOpacity: Double {
        let metrics = opacityMetrics()
        let offset = smallCountdownVerticalPadding / 2
        let end = max(metrics.end - offset, smallCountdownHeight - countdownFrame.height)
        let start = metrics.end + offset
        let duration = start - end
        
        switch scrollPosition {
        case _ where scrollPosition > start:
            return 0
        case _ where scrollPosition <= end:
            return 1
        default:
            return 1.0 - abs((scrollPosition - end) / duration)
        }
    }
    
    func opacityMetrics() -> (start: CGFloat, end: CGFloat, duration: CGFloat) {
        let end: CGFloat = (smallCountdownHeight - smallCountdownVerticalPadding) - (countdownFrame.height - countdownVerticalPadding)
        let duration: CGFloat = countdownTextHeight - (smallCountdownHeight - (smallCountdownVerticalPadding * 2))
        let start: CGFloat = end + duration
        return (start: start, end: end, duration: duration)
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
        max(0, countdownFrame.size.height + safeArea.height + countdownFrame.origin.y + 38)
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

    var countdownView: some View {
        PrayerCountdown(upcoming: viewModel.upcoming,
                        verticalPadding: countdownVerticalPadding,
                        textHeight: $countdownTextHeight)
            .opacity(largeHeaderOpacity)
            .frame(maxWidth: .infinity)
    }

    var stickyHeader: some View {
        SmallPrayerCountdown(upcoming: viewModel.upcoming,
                             verticalPadding: smallCountdownVerticalPadding,
                             safeArea: safeArea,
                             textHeight: $smallCountdownHeight)
            .frame(maxWidth: .infinity)
            .opacity(stickyHeaderOpacity)
            .allowsHitTesting(false)
    }

    var body: some View {
        ZStack(alignment: .top) {
            headerImage
                .frame(maxWidth: safeArea.width)

            HStack {
                Spacer(minLength: 50)
                if viewModel.loading {
                    ProgressView()
                        .tint(.white)
                        .padding(.trailing, 42)
                        .padding(.top, 8)
                }
            }
            
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
//            .if(true) { scrollView in
//                
//                if #available(iOS 17.0, *) {
//                    scrollView.scrollTargetBehavior(.viewAligned)
//                } else {
//                    scrollView
//                }
//            }
        }
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
        }.onGeometryChange(for: CGSize.self) { proxy in
            CGSize(width: proxy.size.width, height: proxy.safeAreaInsets.top)
        } action: { newValue in
            safeArea = newValue
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
