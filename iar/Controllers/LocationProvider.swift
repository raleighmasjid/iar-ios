//
//  LocationProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/17/24.
//

import Foundation
import CoreLocation

protocol LocationProvider: AnyObject {
    var delegate: LocationProviderDelegate? { get set }
    func startUpdating()
    func stopUpdating()
    func requestLocationAccess()
    func requestFullAccuracy()
    var accuracyAuthorization: CLAccuracyAuthorization? { get }
    var headingAvailable: Bool { get }
    var authorizationStatus: CLAuthorizationStatus { get }
}

protocol LocationProviderDelegate: AnyObject {
    func didUpdateHeading(_ heading: Heading?, location: CLLocation?, authorizationStatus: CLAuthorizationStatus)
    func didUpdateLocation(_ location: String)
    func didUpdateAuthorization()
}

class CoreLocationProvider: NSObject, LocationProvider, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    var lastLocation: CLLocation?
    var lastHeading: CLHeading?
    
    weak var delegate: LocationProviderDelegate?
    
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.delegate = self

        locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.headingFilter = kCLHeadingFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    var headingAvailable: Bool {
        CLLocationManager.headingAvailable()
    }
    
    func requestLocationAccess() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard CLLocationManager.locationServicesEnabled() else {
                return
            }
            
            if self.locationManager.authorizationStatus == .notDetermined {
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    var accuracyAuthorization: CLAccuracyAuthorization? {
        guard authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways else {
            return nil
        }
        return locationManager.accuracyAuthorization
    }
 
    func requestFullAccuracy() {
        locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "qibla") { [weak self] error in
            self?.delegate?.didUpdateAuthorization()
        }
    }
    
    func startUpdating() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard CLLocationManager.locationServicesEnabled() else {
                self.delegate?.didUpdateHeading(nil, location: nil, authorizationStatus: .denied)
                return
            }

            switch self.locationManager.authorizationStatus {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.startUpdatingLocation()
                if CLLocationManager.headingAvailable() {
                    self.locationManager.startUpdatingHeading()
                }
            default:
                break
            }
        }
    }
    
    func stopUpdating() {
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }
    
    private func updateHeading() {
        guard let lastHeading = lastHeading, let lastLocation = lastLocation else {
            return
        }
        
        let direction = lastHeading.trueHeading >= 0 ? lastHeading.trueHeading : lastHeading.magneticHeading
        delegate?.didUpdateHeading(Heading(direction: direction, accuracy: lastHeading.headingAccuracy),
                                   location: lastLocation, authorizationStatus: locationManager.authorizationStatus)
    }
    
    private func lookup(location: CLLocation, completion: @escaping (CLPlacemark?)->()) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            DispatchQueue.main.async {
                completion(placemarks?.first)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last,
              location.horizontalAccuracy >= 0 {
            
            lastLocation = location
            lookup(location: location) { placemark in
                if let cityName = placemark?.cityName {
                    self.delegate?.didUpdateLocation(cityName)
                }
            }
            updateHeading()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        lastHeading = newHeading
        updateHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        delegate?.didUpdateAuthorization()
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startUpdating()
        } else if status == .denied || status == .restricted {
            delegate?.didUpdateHeading(nil, location: nil, authorizationStatus: status)
        }
    }
    
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        true
    }
}
