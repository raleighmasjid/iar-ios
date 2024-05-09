//
//  KhutbaView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI
import Kingfisher

struct KhutbaView: View {
    let fridayPrayer: FridayPrayer
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text(fridayPrayer.shift)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.shift)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .opacity(fridayPrayer.shift.isEmpty ? 0 : 1)
                    Spacer(minLength: 5)
                    Text(fridayPrayer.time)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(16)
                .background(Color.brandPrimary)

                VStack(spacing: 0) {
                    Text(fridayPrayer.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20, weight: .regular))
                        .padding(.bottom, 24)
                        .padding(.top, 8)
                    
                    HStack(spacing: 16) {
                        AsyncImage(url: URL(string: fridayPrayer.imageUrl)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.secondaryText.opacity(0.25)
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 2) {
                            Text(fridayPrayer.speaker)
                                .font(.system(size: 17, weight: .semibold))
                            Text(fridayPrayer.description)
                                .font(.system(size: 12))
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
struct KhutbaView_Previews: PreviewProvider {
    static var previews: some View {
        KhutbaView(fridayPrayer: FridayPrayer.mocks()[0])
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.prayerScreenBackground)
        KhutbaView(fridayPrayer: FridayPrayer.mocks()[1])
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.prayerScreenBackground)
        KhutbaView(fridayPrayer: FridayPrayer.mocks()[2])
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.prayerScreenBackground)
        KhutbaView(fridayPrayer: FridayPrayer.mocks()[3])
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.prayerScreenBackground)
    }
}
#endif
