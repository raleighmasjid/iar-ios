//
//  PrimaryContainerButtonStyle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/25.
//

import SwiftUI

struct PrimaryContainerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(16)
            .background(.primaryContainer)
            .cornerRadius(16)
            .opacity(configuration.isPressed ? 0.75 : 1)
    }
}
