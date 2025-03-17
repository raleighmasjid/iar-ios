//
//  RowButtonStyle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/15/25.
//

import SwiftUI

struct RowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .background(configuration.isPressed ? .gray.opacity(0.15) : .clear)
    }
}
