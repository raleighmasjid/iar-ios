//
//  KhutbaView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI
import NukeUI

struct KhutbaView: View {
    let fridayPrayer: FridayPrayer
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text(fridayPrayer.shift)
                        .scalingFont(size: 16, weight: .bold)
                        .foregroundColor(.shift)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.khutbaBackground)
                        .cornerRadius(8)
                        .opacity(fridayPrayer.shift.isEmpty ? 0 : 1)
                    Spacer(minLength: 5)
                    Text(fridayPrayer.time)
                        .scalingFont(size: 20, weight: .bold)
                        .foregroundColor(.white)
                }
                .padding(16)
                .background(Color.brandPrimary)

                VStack(spacing: 0) {
                    Text(fridayPrayer.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .scalingFont(size: 20, weight: .regular)
                        .padding(.bottom, 24)
                        .padding(.top, 8)
                    
                    HStack(spacing: 16) {
                        LazyImage(url: URL(string: fridayPrayer.imageUrl)) { state in
                                if let image = state.image {
                                    image.resizable()
                                } else {
                                    Color.secondaryText.opacity(0.25)
                                }
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 2) {
                            Text(fridayPrayer.speaker)
                                .scalingFont(size: 17, weight: .semibold)
                            Text(fridayPrayer.description)
                                .scalingFont(size: 12)
                                .foregroundColor(.secondaryText)
                        }
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(16)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.textPrimary)
        }
        .background(
            ZStack(alignment: .bottomTrailing) {
                Color.khutbaBackground
                Image(.khutbaDecoration)
            }
        )
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 25, x: 0, y: 5)
    }
}

#if DEBUG
#Preview {
    KhutbaView(fridayPrayer: FridayPrayer.mocks()[0])
        .background(Color.prayerScreenBackground)
}

#Preview {
    KhutbaView(fridayPrayer: FridayPrayer.mocks()[1])
        .background(Color.prayerScreenBackground)
}

#Preview {
    KhutbaView(fridayPrayer: FridayPrayer.mocks()[2])
        .background(Color.prayerScreenBackground)
}

#Preview {
    KhutbaView(fridayPrayer: FridayPrayer.mocks()[3])
        .background(Color.prayerScreenBackground)
}
#endif
