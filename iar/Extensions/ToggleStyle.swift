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
                Image("alarm-on")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.Theme.darkGreen)
                    .opacity(1)
            } else {
                Image("alarm-off")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                    .opacity(0.5)
            }

        }
        
        
    }
}

extension ToggleStyle where Self == AlarmToggleStyle {
    static var alarm: AlarmToggleStyle { .init() }
}
