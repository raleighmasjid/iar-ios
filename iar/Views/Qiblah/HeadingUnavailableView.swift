//
//  HeadingUnavailableView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/15/25.
//

import SwiftUI

struct HeadingUnavailableView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.red)
                .font(.system(size: 32, weight: .medium))
            Text("This device does not support real time compass directions.")
                .foregroundStyle(.primaryText)
                .scalingFont(size: 18)
        }
        .padding(40)
    }
}

#if DEBUG
#Preview("Light Mode") {
    VStack(alignment: .center) {
        HeadingUnavailableView()
            
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.appBackground)
    .environment(\.colorScheme, .light)
}

#Preview("Dark Mode") {
    VStack(alignment: .center) {
        HeadingUnavailableView()
            
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.appBackground)
    .environment(\.colorScheme, .dark)
}
#endif
