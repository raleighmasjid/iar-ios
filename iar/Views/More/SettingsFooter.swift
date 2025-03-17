//
//  SettingsFooter.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/17/25.
//

import SwiftUI

struct SettingsFooter: View {
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            VStack(spacing: 8) {
                Text("Open Daily From Fajr to Isha")
                    .scalingFont(size: 15)
                    .foregroundStyle(.primaryText)
                
                Button {
                    openURL(URL(string: "http://maps.apple.com/?daddr=808+Atwater+St%2C+Raleigh%2C+NC+27607")!)
                } label: {
                    Text("808 Atwater St, Raleigh, NC 27607")
                        .scalingFont(size: 15, weight: .semibold)
                }
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
