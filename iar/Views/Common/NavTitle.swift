//
//  NavTitle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 7/31/25.
//

import SwiftUI

struct NavTitle: ViewModifier {
    
    func body(content: Content) -> some View {
        if #available(iOS 18.0, *) {
            content
                .font(.system(size: 34, weight: .bold, design: .default))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        } else {
            content
                .font(.system(size: 34, weight: .bold, design: .default))
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
        }
    }
}

extension View {
    func navTitle() -> some View {
        modifier(NavTitle())
    }
}
