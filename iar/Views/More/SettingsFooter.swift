//
//  SettingsFooter.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/17/25.
//

import SwiftUI

struct SettingsFooter: View {
    
    @Environment(\.openURL) private var openURL
    
    let directionsViewModel = DirectionsViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            VStack(spacing: 8) {
                Text("Open Daily From Fajr to Isha")
                    .scalingFont(size: 15)
                    .foregroundStyle(.primaryText)

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
                            Text(directionsViewModel.address)
                        }
                        .menuOrder(.fixed)
                    } else {
                        Button {
                            openURL(directionsViewModel.appleMapsURL)
                        } label: {
                            Text(directionsViewModel.address)
                        }
                    }
                }
                .scalingFont(size: 15, weight: .semibold)
                .buttonStyle(SmallPrimaryContainerButtonStyle())
            }
            
            VStack(spacing: 4) {
                Text("The Islamic Association of Raleigh")
                Text(version())
            }
            .foregroundStyle(.secondaryText)
            .font(.system(size: 11))
        }
        .padding(.bottom, 32)
    }
    
    func version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "Version \(version) (\(build))"
    }
}
