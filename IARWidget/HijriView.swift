//
//  HijriView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/19/25.
//

import SwiftUI

struct HijriView: View {
    let components: HijriComponents
    
    var body: some View {
        HStack {
            Text(components.formatted())
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.white)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
        }
        .background(Color.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
    }
}
