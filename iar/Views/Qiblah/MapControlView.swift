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
                if !viewModel.hasFullAccuracy {
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
                Text("Qibla \(qiblaAngle, format: .number.precision(.fractionLength(1)))°")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Color.primaryText)
                    .padding(8)
                    .background(Color.appBackground, in: RoundedRectangle(cornerRadius: 16))
                    .padding(.vertical, 16)
                Spacer()
                VStack(spacing: 8) {
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
                    .buttonStyle(MapButtonStyle())
                    
                    Button {
                        mapStyle.toggle()
                    } label: {
                        Image(systemName: mapStyle.symbolName)
                    }
                    .buttonStyle(MapButtonStyle())
                }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
    }
}
