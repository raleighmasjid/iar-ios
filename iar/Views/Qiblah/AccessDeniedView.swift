//
//  AccessDeniedView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/13/25.
//

import SwiftUI

struct AccessDeniedView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Location access is required to enable compass functionality and show the qibla direction.")
                .foregroundStyle(.primaryText)
                .scalingFont(size: 18, weight: .light)
            Button {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            } label: {
                HStack {
                    Text("Open Settings")
                    Image(systemName: "arrow.right.circle.fill")
                }
                .font(.title2)
            }
        }
        .padding(40)
    }
}

#if DEBUG
#Preview {
    AccessDeniedView()
        .tint(.accent)
}
#endif
