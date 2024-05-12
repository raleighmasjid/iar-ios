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
                    .foregroundColor(.action)
                    .opacity(1)
            } else {
                Image(.alarmOff)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.disabledAction)
            }

        }
        
        
    }
}

extension ToggleStyle where Self == AlarmToggleStyle {
    static var alarm: AlarmToggleStyle { .init() }
}
