//
//  View.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/17/25.
//

import SwiftUI

extension View {
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

struct StickyHeaderScrollTargetBehavior: ScrollTargetBehavior {
    let transitionStart: CGFloat
    let transitionEnd: CGFloat
    
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.origin.y >= transitionStart && target.rect.minY <= transitionEnd {
            target.rect.origin.y = transitionEnd
        }
    }
}
