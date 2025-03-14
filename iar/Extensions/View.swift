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
    
    func targetedScrollView(transitionStart: CGFloat, transitionEnd: CGFloat) -> some View {
        modifier(TargetedScrollView(transitionStart: transitionStart, transitionEnd: transitionEnd))
    }
    
    func largeNavigationTitle(_ title: String) -> some View {
        modifier(LargeNavigationTitle(title: title))
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

struct TargetedScrollView: ViewModifier {
    let transitionStart: CGFloat
    let transitionEnd: CGFloat
    
    func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            content.scrollTargetBehavior(StickyHeaderScrollTargetBehavior(transitionStart: transitionStart, transitionEnd: transitionEnd))
        } else {
            content
        }
    }
}

struct LargeNavigationTitle: ViewModifier {
    
    let title: String
    
    func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            content
                .toolbarTitleDisplayMode(.inlineLarge)
                .navigationTitle(title)
        } else {
            content
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle(title)
        }
    }
}


@available(iOS 17, *)
struct StickyHeaderScrollTargetBehavior: ScrollTargetBehavior {
    let transitionStart: CGFloat
    let transitionEnd: CGFloat
    
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.origin.y >= transitionStart && target.rect.minY <= transitionEnd {
            target.rect.origin.y = transitionEnd
        }
    }
}
