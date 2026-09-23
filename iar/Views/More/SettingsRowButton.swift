//
//  SettingsRowButton.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 9/22/26.
//

import SwiftUI

/// A tappable settings row intended for use as a direct `List` row.
struct SettingsRowButton: View {
    
    let image: Image
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.accent)
                    .frame(width: 18, height: 18)
                Text(title)
                    .scalingFont(size: 16)
                    .foregroundStyle(.primaryText)

                Spacer()

                Image(systemName: "chevron.forward")
                    .foregroundStyle(.accent)
                    .font(.system(size: 18))
            }
            .padding(16)
        }
        .buttonStyle(RowButtonStyle())
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
        .alignmentGuide(.listRowSeparatorLeading) { _ in 16 }
    }
}

#Preview {
    List {
        SettingsRowButton(image: Image(.notificationsIcons), title: "Notifications") {}
    }
    .listStyle(.plain)
    .scrollContentBackground(.hidden)
    .background(.appBackground)
}
