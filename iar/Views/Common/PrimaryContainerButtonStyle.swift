//
//  PrimaryContainerButtonStyle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/25.
//

import SwiftUI

struct PrimaryContainerButtonStyle: ButtonStyle {
    
    let size: PrimaryContainer.Size
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .primaryContainer(size: size)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
