//
//  PostButtonStyle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/15/25.
//

import SwiftUI

struct PostButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(16)
            .background(configuration.isPressed ? .gray.opacity(0.15) : .clear)
    }
}
