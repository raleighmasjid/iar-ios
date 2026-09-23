//
//  MapButtonStyle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 7/30/25.
//

import SwiftUI

struct MapButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.4 : 1)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color.primaryText)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .mapOverlayBackground(in: Capsule())
    }
}

/// Bare version of `MapButtonStyle` with no background of its own,
/// intended for buttons grouped inside a shared glass container.
struct MapIconButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.4 : 1)
            .font(.system(size: 16))
            .foregroundStyle(Color.primaryText)
            .padding(16)
            .contentShape(Rectangle())
    }
}
