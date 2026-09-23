//
//  SettingsRowText.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 9/22/26.
//

import SwiftUI

struct SettingsRowText: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .padding(16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.secondaryText)
            .font(.system(size: 11))
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .alignmentGuide(.listRowSeparatorLeading) { _ in 16 }
    }
}

#Preview {
    List {
        SettingsRowText(text: "App version 1.0 (1)")
    }
    .listStyle(.plain)
    .scrollContentBackground(.hidden)
    .background(.appBackground)
}
