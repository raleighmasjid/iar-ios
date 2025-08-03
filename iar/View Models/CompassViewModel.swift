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
    @Published var isCorrect: Bool = false
    @Published var hasFullAccuracy: Bool = true
    
    let provider: LocationProvider
    
    init(provider: LocationProvider) {
        self.provider = provider
        self.provider.delegate = self
    }
    
    func accuracyAuthorization() -> CLAccuracyAuthorization {
        provider.accuracyAuthorization
    }
    
    func requestFullAccuracy() {
        provider.requestFullAccuracy()
    }
    
    func requestLocationAuthorization() {
        provider.requestLocationAccess()
    }
    
    func startUpdating() {
        if provider.headingAvailable {
            provider.startUpdating()
        } else {
            compassAngle = .unavailable
        }
    }
    
    func stopUpdating() {
        provider.stopUpdating()
    }
    
    func didUpdateAuthorization() {
        hasFullAccuracy = (provider.accuracyAuthorization == .fullAccuracy)
    }
    
    func didUpdateHeading(_ heading: Heading?, location: CLLocation?, authorizationStatus: CLAuthorizationStatus) {
        if authorizationStatus == .denied || authorizationStatus == .restricted {
            compassAngle = .accessDenied
            isCorrect = false
            return
        }
        
        guard let heading = heading, let location = location else {
            compassAngle = .pending
            isCorrect = false
            return
        }
        
        if heading.accuracy < 0 || heading.accuracy >= 90 {
            compassAngle = .invalid
            isCorrect = false
            return
        }
        
        var qibla = Qibla(coordinates: Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)).direction
        qibla -= heading.direction
        if qibla < 0 {
            qibla += 360
        }
        
        let previousAngle = compassAngle.currentAngle ?? 0
        compassAngle = .valid(heading: CompassAngle.adjustedEnd(from: previousAngle, to: qibla), deviation: heading.accuracy)
        isCorrect = percentCorrect > 0
    }
    
    var percentCorrect: Double {
        guard let normalizedSmallestAngle = compassAngle.normalizedSmallestAngle else {
            return -1
        }
        
        return min(1, 1.2 - (abs(normalizedSmallestAngle)/10))
    }
    
    func didUpdateLocation(_ location: String) {
        locationName = location
    }

}
