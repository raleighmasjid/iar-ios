//
//  CompassViewModel.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/16/24.
//

import Foundation
import CoreLocation
import Adhan

class CompassViewModel: ObservableObject, LocationProviderDelegate {

    @Published var locationName: String?
    @Published var compassAngle: CompassAngle = .pending
    
    let provider: LocationProvider
    
    init(provider: LocationProvider) {
        self.provider = provider
        self.provider.delegate = self
    }
    
    func startUpdating() {
        provider.startUpdating()
    }
    
    func stopUpdating() {
        provider.stopUpdating()
    }
    
    func didUpdateHeading(_ heading: Heading?, location: CLLocation?, authorizationStatus: CLAuthorizationStatus) {
        if authorizationStatus == .denied || authorizationStatus == .restricted {
            compassAngle = .accessDenied
            return
        }
        
        guard let heading = heading, let location = location else {
            compassAngle = .pending
            return
        }
        
        if heading.accuracy < 0 || heading.accuracy >= 90 {
            compassAngle = .invalid
        }
        
        var qibla = Qibla(coordinates: Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)).direction
        qibla -= heading.direction
        if qibla < 0 {
            qibla += 360
        }
        compassAngle = .valid(qibla)
    }
    
    func didUpdateLocation(_ location: String) {
        locationName = location
    }

}
