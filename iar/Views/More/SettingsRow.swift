//
//  SettingsRow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/16/25.
//

import SwiftUI

struct SettingsRow: View {
    
    let image: Image
    let title: String
    
    init(image: Image, title: String) {
        self.image = image
        self.title = title
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
            
            Image(systemName: "chevron.forward")
                .foregroundStyle(.accent)
                .font(.system(size: 18))
        }
        .padding(16)
    }
}
