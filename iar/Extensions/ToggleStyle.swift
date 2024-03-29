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
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.darkGreen)
                    .opacity(1)
            } else {
                Image(.alarmOff)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.primary)
                    .opacity(0.5)
            }

        }
        
        
    }
}

extension ToggleStyle where Self == AlarmToggleStyle {
    static var alarm: AlarmToggleStyle { .init() }
}
