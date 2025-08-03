//
//  DirectionsButton.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 7/30/25.
//

import SwiftUI

struct DirectionsButton: View {
    
    let directionsViewModel: DirectionsViewModel
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        Group {
            if directionsViewModel.hasGoogleMaps {
                Menu {
                    Section("Get directions") {
                        Button("Apple Maps") {
                            openURL(directionsViewModel.appleMapsURL)
                        }
                        Button("Google Maps") {
                            openURL(directionsViewModel.googleMapsURL)
                        }
                    }
                } label: {
                    buttonLabel(title: directionsViewModel.name)
                }
                .menuOrder(.fixed)
            } else {
                Button {
                    openURL(directionsViewModel.appleMapsURL)
                } label: {
                    buttonLabel(title: directionsViewModel.name)
                }
            }
        }
        .scalingFont(size: 15, weight: .semibold)
        .buttonStyle(PrimaryContainerButtonStyle(size: .small))
    }
    
    func buttonLabel(title: String) -> some View {
        HStack(spacing: 5) {
            Image(.locationMarker)
            Text(title)
                .minimumScaleFactor(0.5)
                .allowsTightening(true)
        }.frame(maxWidth: .infinity, alignment: .center)
    }
}
