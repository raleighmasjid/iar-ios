//
//  QiblaCompass.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 7/30/25.
//

import SwiftUI

struct QiblaCompass: View {
    
    @ObservedObject var viewModel: CompassViewModel
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var didEnterBackground = false
    @State private var isVisible: Bool = false
    private let feedback = UIImpactFeedbackGenerator()
    
    var body: some View {
        VStack(alignment: .center) {
            switch viewModel.compassAngle {
            case .unavailable:
                HeadingUnavailableView()
            case .accessDenied:
                AccessDeniedView()
            case .invalid:
                InvalidHeadingView()
            case .valid(let angle, _):
                CompassView(
                    angle: angle,
                    percentCorrect: viewModel.percentCorrect
                )
            default:
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.primaryText)
                    .controlSize(.large)
            }
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .onAppear {
            isVisible = true
            viewModel.startUpdating()
            feedback.prepare()
        }
        .onDisappear {
            isVisible = false
            viewModel.stopUpdating()
        }
        .onChange(of: viewModel.isCorrect) { _, newValue in
            if isVisible {
                if newValue {
                    feedback.impactOccurred(intensity: 1.0)
                } else {
                    feedback.impactOccurred(intensity: 0.5)
                }
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
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
