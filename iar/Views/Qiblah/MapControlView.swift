//
//  MapControlView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 7/31/25.
//

import SwiftUI
import MapKit

struct MapControlView: View {
    
    @Binding
    var mapPosition: MapCameraPosition
    
    @Binding
    var mapStyle: MapDisplayStyle
    
    @Binding
    var qiblaAngle: Double
    
    @ObservedObject var viewModel: CompassViewModel
    
    var body: some View {
        VStack {
            HStack {
                if viewModel.accuracy == .reducedAccuracy {
                    Spacer()
                    Button {
                        viewModel.requestFullAccuracy()
                    } label: {
                        Text("\(Image(systemName: "location.magnifyingglass")) Full Accuracy")
                    }
                    .buttonStyle(MapButtonStyle())
                }
            }
            Spacer()
            HStack(alignment: .bottom) {
                Text("Qibla: \(qiblaAngle, format: .number.precision(.fractionLength(1)))°")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.primaryText)
                    .padding(12)
                    .mapOverlayBackground(in: Capsule())
                Spacer()
                VStack(spacing: 0) {
                    Button {
                        withAnimation {
                            if mapPosition.followsUserLocation {
                                mapPosition = .automatic
                            } else {
                                mapPosition = .userLocation(followsHeading: false, fallback: .automatic)
                            }
                        }
                    } label: {
                        Image(systemName: mapPosition.followsUserLocation ? "location.fill" : "location")
                    }
                    .buttonStyle(MapIconButtonStyle())
                    
                    Divider()
                        .frame(width: 24)
                    
                    Button {
                        mapStyle.toggle()
                    } label: {
                        Image(systemName: mapStyle.symbolName)
                    }
                    .buttonStyle(MapIconButtonStyle())
                }
                .mapOverlayBackground(in: Capsule())
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 40)
        .padding(.horizontal, 22)
    }
}
