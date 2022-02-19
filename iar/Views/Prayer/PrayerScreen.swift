//
//  PrayerScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI

struct PrayerScreen: View {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var viewModel: PrayerTimesViewModel
    @State var dayOffset = 0
    @State var didEnterBackground = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    PrayerCountdown(upcoming: viewModel.upcoming)
                    PrayerHeader(prayerDays: viewModel.prayerDays, dayOffset: $dayOffset)
                    
                    columnHeaders
                    
                    if viewModel.prayerDays.count > 0 {
                        TabView(selection: $dayOffset) {
                            ForEach(0..<viewModel.prayerDays.count, id: \.self) {
                                PrayerView(prayerDay: viewModel.prayerDay(offset: $0))
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: 275)
                    } else {
                        PrayerView(prayerDay: nil)
                    }
                    
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
                    dayOffset = 0
                case .active:
                    if didEnterBackground {
                        didEnterBackground = false
                        viewModel.fetchLatest()
                    }
                default:
                    break
                }
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
    
    var columnHeaders: some View {
        HStack() {
            Text("Prayer")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Adhan")
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Iqamah")
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Spacer().frame(width: 43)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .font(.system(size: 16, weight: .regular))
        .foregroundColor(.white)
        .background(Color.Theme.darkGreen)
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
