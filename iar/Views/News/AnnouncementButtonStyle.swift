//
//  AnnouncementButtonStyle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/25.
//

import SwiftUI

struct AnnouncementButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.primaryContainer)
            .cornerRadius(16)
            .opacity(configuration.isPressed ? 0.75 : 1)
    }
}
