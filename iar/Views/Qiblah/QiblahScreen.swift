//
//  QiblahScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/16/24.
//

import SwiftUI

struct QiblahScreen: View {

    let feedback = UIImpactFeedbackGenerator()
    
    @ObservedObject var viewModel: CompassViewModel
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.sizeCategory) var sizeCategory
    @State var didEnterBackground = false
    
    @State var rotationAngle: Double = 0
    @State var isVisible: Bool = false
    @ScaledMetric private var markerHeight: Double = 14
    
    var isValid: Bool {
        switch viewModel.compassAngle {
        case .valid:
            true
        default:
            false
        }
    }
    
    var isPending: Bool {
        switch viewModel.compassAngle {
        case .invalid, .pending:
            true
        default:
            false
        }
    }
    
    var isDenied: Bool {
        switch viewModel.compassAngle {
        case .accessDenied:
            true
        default:
            false
        }
    }
    
    var percentCorrect: Double {
        switch viewModel.compassAngle {
        case .valid(let angle) where angle >= 350 || angle <= 10:
            let smallAngle = angle > 180 ? angle - 360 : angle
            return min(1, 1.2 - (abs(smallAngle)/10))
        default:
            return -1
        }
    }
    
    @State var isCorrect: Bool = false
    
    @ViewBuilder func headerView() -> some View {
        if sizeCategory >= .accessibilityMedium {
            VStack(alignment: .leading, spacing: 0) {
                headerContent()
            }.frame(maxWidth: .infinity, alignment: .leading)
            
        } else {
            HStack(spacing: 0) {
                headerContent()
            }
        }
    }
    
    @ViewBuilder func headerContent() -> some View {
        Text("Qibla")
            .scalingFont(size: 28, weight: .bold)
            .foregroundStyle(.textPrimary)
        if sizeCategory < .accessibilityMedium {
            Spacer(minLength: 20)
        }
        HStack {
            Image(.locationMarker)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: markerHeight)
            Text(viewModel.locationName ?? "---")
        }
        .scalingFont(size: 15, weight: .medium)
        .foregroundStyle(.action)
        .padding(12)
        .background(.specialAnnouncement)
        .cornerRadius(12)
    }

    var body: some View {
        VStack {
            headerView()
                .padding()
            
            Spacer()
            
            ZStack {
                VStack(spacing: 30) {
                    Text("Location access is required to enable compass functionality and show the qibla direction.")
                        .foregroundStyle(.textPrimary)
                        .scalingFont(size: 18, weight: .light)
                    Button {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    } label: {
                        HStack {
                            Text("Open Settings")
                            Image(systemName: "arrow.right.circle.fill")
                        }
                        .font(.title2)
                    }
                }
                .padding(40)
                .opacity(isDenied ? 1 : 0)
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.large)
                    .opacity(isPending ? 1 : 0)
                VStack(spacing: 32) {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.action)
                        .opacity(percentCorrect)
                        .animation(.easeInOut(duration: 0.15), value: percentCorrect)
                    CompassView(angle: rotationAngle, percentCorrect: percentCorrect)
                        .onAppear {
                            isVisible = true
                            viewModel.startUpdating()
                            feedback.prepare()
                        }
                        .onDisappear {
                            isVisible = false
                            viewModel.stopUpdating()
                        }
                        .opacity(isValid ? 1 : 0)
                }
            }
            Text(makkahText)
                .scalingFont(size: 22, weight: .bold)
                .minimumScaleFactor(0.1)
                .opacity(percentCorrect)
                .animation(.easeInOut(duration: 0.15), value: percentCorrect)
                .padding(.horizontal, 32)

            Spacer()
        }
        .lineLimit(1)
        .onReceive(viewModel.$compassAngle) { angle in
            switch angle {
            case .valid(let angleValue):
                rotationAngle = adjustedEnd(from: rotationAngle, to: angleValue)
            default:
                break
            }
            isCorrect = percentCorrect > 0
        }
        .onChange(of: isCorrect) { newValue in
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
    
    var makkahText: AttributedString {
        var text1 = AttributedString("You're Facing ")
        text1.foregroundColor = .textPrimary
        var text2 = AttributedString("Makkah")
        text2.foregroundColor = .action
        return text1 + text2
    }
    
    func adjustedEnd(from start: Double, to target: Double) -> Double {
        // Shift end to be greater than start
        var end = target
        while end < start { end += 360 }

        // Mod the distance with 360, shifting by 180 to keep on the same side of a circle
        return (end - start + 180).truncatingRemainder(dividingBy: 360) - 180 + start
    }
}

#if DEBUG
#Preview {
    QiblahScreen(viewModel: CompassViewModel(provider: MockLocationProvider()))
}

#Preview("Denied Location") {
    QiblahScreen(viewModel: CompassViewModel(provider: MockDeniedLocationProvider()))
}

#Preview("Almost Valid") {
    QiblahScreen(viewModel: CompassViewModel(provider: MockAlmostValidLocationProvider()))
}
#endif
