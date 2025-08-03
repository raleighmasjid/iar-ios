//
//  QiblaMap.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 7/31/25.
//

import SwiftUI
import MapKit
import Adhan

struct QiblaMap: View {
    
    @State private var mapPosition = MapCameraPosition.userLocation(followsHeading: false, fallback: .automatic)
    @State private var mapStyle: MapDisplayStyle = .hybrid
    @State private var qiblaAngle: Double = 0
    @ObservedObject var viewModel: CompassViewModel
    
    var body: some View {
        ZStack {
            Map(position: $mapPosition, interactionModes: [.pan, .zoom]) {
                UserAnnotation()
            }
            .mapStyle(mapStyle.mapStyle)
            .mapControls {
                MapScaleView()
            }
            .onMapCameraChange(frequency: .continuous) { context in
                let coordinates = Coordinates(
                    latitude:context.camera.centerCoordinate.latitude,
                    longitude: context.camera.centerCoordinate.longitude
                )
                
                qiblaAngle = Qibla(coordinates: coordinates).direction
            }
            MapArrow(direction: $qiblaAngle)
                .allowsHitTesting(false)
            MapControlView(mapPosition: $mapPosition, mapStyle: $mapStyle, qiblaAngle: $qiblaAngle, viewModel: viewModel)
        }
    }
}
