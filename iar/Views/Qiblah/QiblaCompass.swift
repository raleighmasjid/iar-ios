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
    @State private var showExpandedMessage: Bool = false
    private let feedback = UIImpactFeedbackGenerator()
    
    var accuracyMessage: String {
        if showExpandedMessage {
            return "Compass direction may not be 100% accurate when used inside or near electric or magnetic interference. Please verify with map overlay."
        } else {
            return "Compass direction may not be 100% accurate."
        }
    }
    
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
                Spacer()
                CompassView(
                    angle: angle,
                    percentCorrect: viewModel.percentCorrect
                )
                Spacer()
                Button {
                    withAnimation(.snappy) {
                        showExpandedMessage.toggle()
                    }
                } label: {
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "info.circle.fill")
                        Group {
                            if showExpandedMessage {
                                Text("Compass direction may not be 100% accurate when used indoors or near electric or magnetic interference. Please verify Qibla with the map overlay.")
                            } else {
                                Text("Compass direction may not be 100% accurate")
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .allowsTightening(true)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .scalingFont(size: 13)
                        Image(systemName: "chevron.down")
                            .rotationEffect(Angle(degrees: showExpandedMessage ? 180 : 0))
                            .imageScale(.small)
                            .bold()
                    }
                }
                .buttonStyle(PrimaryContainerButtonStyle(size: .large))
                .padding(.top, 32)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)

                //#if DEBUG
                //                        Text("Heading Accuracy: ±\(String(format: "%0.1f", deviation))°")
                //                            .opacity(deviation > 1 ? 1 : 0)
                //                            .padding(.bottom, 16)
                //                            .font(.caption)
                //                            .foregroundStyle(.secondaryText)
                //#endif
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
