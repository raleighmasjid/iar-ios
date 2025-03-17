//
//  SettingsPickerRow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/16/25.
//

import SwiftUI

struct SettingsPickerRow<Content: View>: View {
    
    let image: Image
    let title: String
    let content: Content
    
    init(image: Image, title: String, @ViewBuilder content: () -> Content) {
        self.image = image
        self.title = title
        self.content = content()
    }
    
    var body: some View {
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
            
            content
        }
        .padding(.leading, 16)
        .padding(.trailing, 8)
        .padding(.vertical, 8)
    }
}
