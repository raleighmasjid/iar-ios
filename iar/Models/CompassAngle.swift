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
    
    var normalizedSmallestAngle: Double? {
        guard case let .valid(angle) = self else {
            return nil
        }
        
        var correctedAngle = angle
        while correctedAngle < 0 { correctedAngle += 360 }
        correctedAngle = correctedAngle - (360 * (floor(correctedAngle / 360)))

        return correctedAngle > 180 ? correctedAngle - 360 : correctedAngle
    }
    
    var currentAngle: Double? {
        guard case let .valid(angle) = self else {
            return nil
        }
        
        return angle
    }
    
    static func adjustedEnd(from start: Double, to target: Double) -> Double {
        // Shift end to be greater than start
        var end = target
        while end < start { end += 360 }

        // Mod the distance with 360, shifting by 180 to keep on the same side of a circle
        return (end - start + 180).truncatingRemainder(dividingBy: 360) - 180 + start
    }
}
