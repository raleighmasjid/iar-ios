//
//  DirectionsViewModel.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/19/25.
//

import Foundation
import UIKit

struct DirectionsViewModel {
    
    let address: String
    let name: String
    let googleMapsURL: URL
    let appleMapsURL: URL
    
    init(address: String, name: String) {
        self.address = address
        self.name = name
        let urlEncodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        self.googleMapsURL = URL(string: "comgooglemaps://?saddr=&daddr=\(urlEncodedAddress)&directionsmode=driving")!
        self.appleMapsURL = URL(string: "http://maps.apple.com/?daddr=\(urlEncodedAddress)")!
    }
    
    var hasGoogleMaps: Bool {
        UIApplication.shared.canOpenURL(googleMapsURL)
    }
    
    static let atwaterSt = DirectionsViewModel(address: "808 Atwater St, Raleigh, NC 27607", name: "Atwater St")
    static let pageRd = DirectionsViewModel(address: "3104 Page Rd, Morrisville, NC 27560", name: "Page Rd")
}
