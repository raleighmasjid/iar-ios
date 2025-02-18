//
//  CompassAngle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/17/24.
//

import Foundation
import CoreLocation

public enum CompassAngle {
    case valid(Double)
    case invalid
    case pending
    case accessDenied
}
