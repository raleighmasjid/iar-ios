//
//  QiblaScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/16/24.
//

import SwiftUI

struct QiblaScreen: View {
    
    @ObservedObject var viewModel: CompassViewModel
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var didEnterBackground = false
    
    @State private var availableHeight: CGFloat = 0
    @State private var isVisible: Bool = false
    
    private let feedback = UIImpactFeedbackGenerator()
    
    var body: some View {
        // workaround for bug with iOS 18.0 and inlineLargeTitle
        ScrollView{
            VStack(alignment: .center) {
                switch viewModel.compassAngle {
                case .accessDenied:
                    AccessDeniedView()
                case .valid(let angle):
                    QiblaCompass(angle: angle, percentCorrect: viewModel.percentCorrect)
                default:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.primaryText)
                        .controlSize(.large)
                }
            }
            .frame(height: availableHeight)
            .frame(maxWidth: .infinity)
        }
        .scrollDisabled(true)
        .onGeometryChange(for: CGFloat.self) { proxy in
            proxy.size.height
        } action: { newValue in
            availableHeight = newValue
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                LocationCard(locationName: viewModel.locationName)
                .padding(.top, 24)
            }
        }
        .onAppear {
            isVisible = true
            viewModel.startUpdating()
            feedback.prepare()
        }
        .onDisappear {
            isVisible = false
            viewModel.stopUpdating()
        }
        .onChange(of: viewModel.isCorrect) { newValue in
            if isVisible {
                if newValue {
                    feedback.impactOccurred(intensity: 1.0)
                } else {
                    feedback.impactOccurred(intensity: 0.5)
                }
            }
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background:
                didEnterBackground = true
                viewModel.stopUpdating()
            case .active:
                if didEnterBackground {
                    didEnterBackground = false
                    if isVisible {
                        viewModel.startUpdating()
                    }
                }
            default:
                break
            }
        }
        
    }
}

#if DEBUG
#Preview {
    QiblaScreen(viewModel: CompassViewModel(provider: MockLocationProvider()))
}

#Preview("Denied Location") {
    QiblaScreen(viewModel: CompassViewModel(provider: MockDeniedLocationProvider()))
}

#Preview("Almost Valid") {
    QiblaScreen(viewModel: CompassViewModel(provider: MockAlmostValidLocationProvider()))
}
#endif
