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
            .font(.system(size: 16))
            .foregroundStyle(Color.primaryText)
            .padding(16)
            .background(Color.appBackground, in: RoundedRectangle(cornerRadius: 16))
    }
}
