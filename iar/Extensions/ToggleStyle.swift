//
//  ToggleStyle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/5/22.
//

import Foundation
import SwiftUI

struct AlarmToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            if configuration.isOn {
                Image(.alarmOn)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                    .foregroundStyle(.accent)
            } else {
                Image(.alarmOff)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                    .foregroundStyle(.tertiaryText)
            }

        }
        
        
    }
}

extension ToggleStyle where Self == AlarmToggleStyle {
    static var alarm: AlarmToggleStyle { .init() }
}
