//
//  AlarmToggleStyle.swift
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
                Image(systemName: "alarm.fill")
                    .renderingMode(.template)
                    .foregroundColor(.Theme.darkGreen)
                    .opacity(1)
            } else {
                Image(systemName: "alarm")
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .opacity(0.5)
            }

        }
        
        
    }
}

extension ToggleStyle where Self == AlarmToggleStyle {
    static var alarm: AlarmToggleStyle { .init() }
}
