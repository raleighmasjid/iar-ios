//
//  PrimaryContainerButtonStyle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/25.
//

import SwiftUI

struct SmallPrimaryContainerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.accent)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(.primaryContainer)
            .cornerRadius(12)
            .opacity(configuration.isPressed ? 0.75 : 1)
    }
}
