//
//  DonateScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct DonateScreen: View {
    
    @Environment(\.openURL) private var openURL
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    let donateURL = URL(string: "https://donate.raleighmasjid.org/giving")!
    
    var body: some View {
        VStack(alignment: .center, spacing: 48) {
            Spacer(minLength: 5)
            Image(.donateGraphic)
                .resizable()
                .scaledToFit()
                .layoutPriority(0.5)
            
            Text("Your Masjid relies on the generous people of this community to keep its doors open. Consider donating to help cover our running costs.")
                .scalingFont(size: 16)
                .foregroundColor(.secondaryText)
                .multilineTextAlignment(.center)
                .layoutPriority(1)
                .minimumScaleFactor(0.5)
            
            Button {
                openURL(donateURL)
            } label: {
                Text("Donate Now")
                    .frame(maxWidth: .infinity)
                    .scalingFont(size: 16, weight: .semibold)
            }
            .buttonStyle(PrimaryContainerButtonStyle(size: .medium))
            .layoutPriority(0.75)
            
            Spacer(minLength: 5)
        }
        .padding(.horizontal, sizeClass == .regular ? 200 : 50)
        .background(.appBackground)
    }
}

#Preview("Light Mode") {
    DonateScreen()
}

#Preview("Dark Mode") {
    DonateScreen()
        .environment(\.colorScheme, .dark)
}
