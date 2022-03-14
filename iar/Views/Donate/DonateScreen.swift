//
//  DonateScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct DonateScreen: View {
    var body: some View {
        VStack(alignment: .center, spacing: 48) {
            Spacer(minLength: 5)
            Image("donate-graphic")
                .resizable()
                .scaledToFit()
                .layoutPriority(0.5)
            
            Text("Your Masjid relies on the generous people of this community to keep its doors open. Consider donating to help cover our running costs.")
                .font(.system(size: 16))
                .foregroundColor(.Theme.secondaryText)
                .multilineTextAlignment(.center)
                .layoutPriority(1)
            Button(action: {
                    
                }) {
                    Link("Donate Now", destination: URL(string: "https://raleighmasjid.org/donate/")!)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 16, weight: .semibold))
                        .padding()
                        .foregroundColor(.Theme.darkGreen)
                }
                .background(Color.Theme.segmentedBackground)
                .cornerRadius(27)
                .layoutPriority(0.75)
            Spacer(minLength: 5)
        }.padding(.horizontal, 50)
    }
}

struct DonateScreen_Previews: PreviewProvider {
    static var previews: some View {
        DonateScreen()
    }
}
