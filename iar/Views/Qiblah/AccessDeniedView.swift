//
//  AccessDeniedView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/13/25.
//

import SwiftUI

struct AccessDeniedView: View {
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.red)
                .font(.system(size: 32, weight: .medium))
            Text("Location access is required to enable compass functionality and show the qibla direction.")
                .foregroundStyle(.primaryText)
                .scalingFont(size: 18)
            Button {
                openURL(URL(string: UIApplication.openSettingsURLString)!)
            } label: {
                Text("System Settings")
                    .font(.headline)
            }
            .buttonStyle(PrimaryContainerButtonStyle(size: .medium))
        }
        .padding(40)
    }
}

#if DEBUG
#Preview("Light Mode") {
    VStack(alignment: .center) {
        AccessDeniedView()
            
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.appBackground)
    .environment(\.colorScheme, .light)
    .tint(.accent)
}

#Preview("Dark Mode") {
    VStack(alignment: .center) {
        AccessDeniedView()
            
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.appBackground)
    .environment(\.colorScheme, .dark)
    .tint(.accent)
}
#endif
