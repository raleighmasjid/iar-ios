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
        
        let previousAngle: Double = switch compassAngle {
        case .valid(let angle):
            angle
        default:
            0
        }
        
        compassAngle = .valid(adjustedEnd(from: previousAngle, to: qibla))
        isCorrect = percentCorrect > 0
    }
    
    var percentCorrect: Double {
        switch compassAngle {
        case .valid(let angle) where angle >= 350 || angle <= 10:
            let smallAngle = angle > 180 ? angle - 360 : angle
            return min(1, 1.2 - (abs(smallAngle)/10))
        default:
            return -1
        }
    }
    
    func adjustedEnd(from start: Double, to target: Double) -> Double {
        // Shift end to be greater than start
        var end = target
        while end < start { end += 360 }

        // Mod the distance with 360, shifting by 180 to keep on the same side of a circle
        return (end - start + 180).truncatingRemainder(dividingBy: 360) - 180 + start
    }
    
    func didUpdateLocation(_ location: String) {
        locationName = location
    }

}
