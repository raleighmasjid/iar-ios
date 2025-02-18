//
//  QiblahScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/16/24.
//

import SwiftUI

struct QiblahScreen: View {

    @ObservedObject var viewModel: CompassViewModel
    
    @Environment(\.scenePhase) var scenePhase
    @State var didEnterBackground = false
    
    @State var rotationAngle: Double = 0
    @State var isVisible: Bool = false
    
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

    var body: some View {
        VStack {
            HStack {
                Text("Qibla")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.textPrimary)
                Spacer()
                HStack {
                    Image(.locationMarker)
                    Text(viewModel.locationName ?? "---")
                }
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.action)
                .padding(12)
                .background(.specialAnnouncement)
                .cornerRadius(12)
            }
            .padding()
            Spacer()
            ZStack {
                VStack(spacing: 30) {
                    Text("Location access is required to enable compass functionality and show the qibla direction.")
                        .foregroundStyle(.textPrimary)
                        .font(.system(size: 18, weight: .light))
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
                        }
                        .onDisappear {
                            isVisible = false
                            viewModel.stopUpdating()
                        }
                        .opacity(isValid ? 1 : 0)
                }
            }
            HStack(spacing: 0) {
                Text("You're Facing ")
                    .foregroundStyle(.textPrimary)
                Text("Makkah")
                    .foregroundStyle(.action)
            }
            .font(.system(size: 22, weight: .bold))
            .opacity(percentCorrect)
            .animation(.easeInOut(duration: 0.15), value: percentCorrect)
            Spacer()
        }
        .onReceive(viewModel.$compassAngle) { angle in
            switch angle {
            case .valid(let angleValue):
                rotationAngle = adjustedEnd(from: rotationAngle, to: angleValue)
            default:
                break
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
