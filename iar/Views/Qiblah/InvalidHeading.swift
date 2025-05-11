//
//  InvalidHeading.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/11/25.
//

import SwiftUI

struct InvalidHeadingView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.accent)
                .font(.system(size: 32, weight: .medium))
            Text("Unable to determine heading. Try moving to away from any strong magnetic fields or electronic devices.")
                .foregroundStyle(.primaryText)
                .scalingFont(size: 18)
        }
        .padding(40)
    }
}

#if DEBUG
#Preview("Light Mode") {
    VStack(alignment: .center) {
        InvalidHeadingView()
            
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.appBackground)
    .environment(\.colorScheme, .light)
}

#Preview("Dark Mode") {
    VStack(alignment: .center) {
        InvalidHeadingView()
            
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.appBackground)
    .environment(\.colorScheme, .dark)
}
#endif
