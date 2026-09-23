//
//  QiblaScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/16/24.
//

import SwiftUI
import MapKit

struct QiblaScreen: View {
    
    @ObservedObject var viewModel: CompassViewModel
    
    @State private var mode: QiblaMode = .map
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Qibla Mode", selection: $mode) {
                    ForEach(QiblaMode.allCases, id: \.self) { mode in
                        Text(mode.title)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                
                VStack {
                    switch mode {
                    case .map:
                        QiblaMap(viewModel: viewModel)
                    case .compass:
                        QiblaCompass(viewModel: viewModel)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .background(.appBackground)
            .inlineLargeTitleScrollFix()
            .hiddenToolbarBackgroundIfAvailable()
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationTitle("Qibla")
            .toolbar {
                if mode == .compass {
                    ToolbarItem (placement: .navigationBarTrailing) {
                        LocationCard(locationName: viewModel.locationName)
                    }
                    .removeGlass()
                }
            }
        }
        .onAppear {
            viewModel.requestLocationAuthorization()
        }
    }
}

#if DEBUG
#Preview {
    QiblaScreen(viewModel: CompassViewModel(provider: MockLocationProvider()))
        .environment(\.colorScheme, .light)
}

#Preview("Denied Location") {
    QiblaScreen(viewModel: CompassViewModel(provider: MockDeniedLocationProvider()))
        .tint(.accent)
        .environment(\.colorScheme, .light)
}

#Preview("Unavailable") {
    QiblaScreen(viewModel: CompassViewModel(provider: MockUnavailableLocationProvider()))
        .tint(.accent)
        .environment(\.colorScheme, .light)
}

#Preview("Almost Valid") {
    QiblaScreen(viewModel: CompassViewModel(provider: MockAlmostValidLocationProvider()))
        .tint(.accent)
        .environment(\.colorScheme, .dark)
}
#endif
