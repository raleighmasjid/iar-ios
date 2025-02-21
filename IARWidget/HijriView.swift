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
        Text(components.formatted())
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.5)
    }
}
