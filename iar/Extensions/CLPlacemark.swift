//
//  CLPlacemark.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/21/24.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    var cityName: String {
        if let locality = self.locality {
            return locality
        } else if let subLocality = self.subLocality {
            return subLocality
        } else if let administrativeArea = self.administrativeArea {
            return administrativeArea
        } else if let country = self.country {
            return country
        }

        return ""
    }
}
