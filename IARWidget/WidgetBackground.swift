//
//  WidgetBackground.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/18/25.
//

import SwiftUI
import WidgetKit

extension View {
    func widgetBackground<Background: View>(@ViewBuilder _ backgroundBuilder: () -> Background) -> some View {
        modifier(WidgetBackground(backgroundBuilder))
    }
}

struct WidgetBackground<Background: View>: ViewModifier {
    
    let background: Background
    
    init(@ViewBuilder _ backgroundBuilder: () -> Background) {
        self.background = backgroundBuilder()
    }
    
    func body(content: Content) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            content
                .containerBackground(for: .widget) {
                    background
                }
        } else {
            ZStack {
                background
                content
            }
        }
    }
}
