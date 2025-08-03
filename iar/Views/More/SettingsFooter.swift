//
//  SettingsFooter.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/17/25.
//

import SwiftUI

struct SettingsFooter: View {
    let atwaterStViewModel = DirectionsViewModel.atwaterSt
    let pageRdViewModel = DirectionsViewModel.pageRd
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            VStack(spacing: 8) {
                Text("Open Daily From Fajr to Isha")
                    .scalingFont(size: 15)
                    .foregroundStyle(.primaryText)

                HStack(spacing: 8) {
                    DirectionsButton(directionsViewModel: atwaterStViewModel)
                    DirectionsButton(directionsViewModel: pageRdViewModel)
                }.padding(.horizontal, 16)
            }
        }
        .padding(.bottom, 32)
    }
}
