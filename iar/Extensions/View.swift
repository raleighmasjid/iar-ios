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
    
    /// Works around a visual glitch with `.toolbarTitleDisplayMode(.inlineLarge)` on iOS versions prior to 26,
    /// where the navigation bar's large-title collapse misbehaves when the view hierarchy has no underlying
    /// scroll view for it to track. Injects an inert, invisible `ScrollView` behind the content so the
    /// navigation bar has something to observe.
    func inlineLargeTitleScrollFix() -> some View {
        modifier(InlineLargeTitleScrollFix())
    }

    /// Hides the navigation bar's background, using `toolbarBackgroundVisibility(_:for:)` which is only
    /// available on iOS 18+. No-op on earlier versions.
    func hiddenToolbarBackgroundIfAvailable() -> some View {
        modifier(HiddenToolbarBackgroundIfAvailable())
    }
    
    /// Applies Liquid Glass on iOS 26+, falling back to a flat
    /// `Color.appBackground` fill on older OS versions.
    @ViewBuilder
    func mapOverlayBackground(in shape: some Shape) -> some View {
        if #available(iOS 26.0, *) {
            self.glassEffect(.regular, in: shape)
        } else {
            self.background(.regularMaterial, in: shape)
        }
    }
}

extension ToolbarItem {
    func removeGlass() -> some ToolbarContent {
        if #available(iOS 26.0, *) {
            return self.sharedBackgroundVisibility(.hidden)
        } else {
            return self
        }
    }
}

struct InlineLargeTitleScrollFix: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content
        } else {
            content
                .background(
                    ScrollView {
                        Color.clear.frame(height: 1)
                    }
                    .allowsHitTesting(false)
                )
        }
    }
}

struct HiddenToolbarBackgroundIfAvailable: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content
        } else if #available(iOS 18, *) {
            content
                .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        } else {
            content
        }
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
