//
//  View.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/17/25.
//

import SwiftUI

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func scalingFont(size: Double, weight: Font.Weight = .regular, maxSize: Double? = nil) -> some View {
        modifier(ScalingFont(size: size, weight: weight, maxSize: maxSize))
    }
}

struct ScalingFont: ViewModifier {
    @ScaledMetric
    var size: Double
    let weight: Font.Weight
    var maxSize: Double? = nil
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: min(size, maxSize ?? size), weight: weight))
    }
}
