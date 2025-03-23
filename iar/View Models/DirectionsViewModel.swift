//
//  DirectionsViewModel.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/19/25.
//

import Foundation
import UIKit

struct DirectionsViewModel {
    
    let googleMapsURL: URL
    let appleMapsURL: URL
    let address: String
    
    init() {
        address = "808 Atwater St, Raleigh, NC 27607"
        let urlEncodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        googleMapsURL = URL(string: "comgooglemaps://?saddr=&daddr=\(urlEncodedAddress)&directionsmode=driving")!
        appleMapsURL = URL(string: "http://maps.apple.com/?daddr=\(urlEncodedAddress)")!
    }
    
    var hasGoogleMaps: Bool {
        UIApplication.shared.canOpenURL(googleMapsURL)
    }
}
