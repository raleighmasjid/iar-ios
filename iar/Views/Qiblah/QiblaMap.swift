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
    
    @ObservedObject var viewModel: CompassViewModel
    
    @State private var mapPosition = MapCameraPosition.userLocation(
        followsHeading: false,
        fallback: .automatic
    )
    
    @State private var mapStyle: MapDisplayStyle = .hybrid
    @State private var qiblaAngle: Double = 0

    
    func setFallback() {
        guard !mapPosition.positionedByUser else {
            return
        }
        
        if viewModel.authorizationStatus == .denied || viewModel.authorizationStatus == .restricted {
            mapPosition = MapCameraPosition.camera(
                MapCamera(
                    centerCoordinate: CLLocationCoordinate2D(latitude: 35.78977019151847, longitude: -78.691211012544),
                    distance: 750
                )
            )
        }
    }
    
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
        .onAppear {
            setFallback()
        }
        .onChange(of: viewModel.authorizationStatus) { _, newValue in
            setFallback()
        }
    }
}
