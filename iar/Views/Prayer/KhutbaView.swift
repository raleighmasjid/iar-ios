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
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.Theme.shiftColor)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .cornerRadius(8)
                        .opacity(fridayPrayer.shift.isEmpty ? 0 : 1)
                    Spacer(minLength: 5)
                    Text(fridayPrayer.time)
                        .font(.system(size: 16, weight: .bold))
                }

                Text(fridayPrayer.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18, weight: .regular))
                    .padding(.vertical, 24)
                
                HStack {
                    if URL(string: fridayPrayer.imageUrl) != nil {
                        KFImage.url(URL(string: fridayPrayer.imageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 42, height: 42)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    VStack(alignment: .leading) {
                        Text(fridayPrayer.speaker)
                            .font(.system(size: 16, weight: .semibold))
                        Text(fridayPrayer.description)
                            .font(.system(size: 13, weight: .light))
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .foregroundColor(.white)
        }
        .background(
            ZStack(alignment: .topLeading) {
                Image("khutba-back")
                    .resizable()
                Image("khutba-decoration")
            }
        )
        .cornerRadius(8)
    }
}

#if DEBUG
struct KhutbaView_Previews: PreviewProvider {
    static var previews: some View {
        KhutbaView(fridayPrayer: FridayPrayer.mocks()[0])
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        KhutbaView(fridayPrayer: FridayPrayer.mocks()[1])
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        KhutbaView(fridayPrayer: FridayPrayer.mocks()[2])
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        KhutbaView(fridayPrayer: FridayPrayer.mocks()[3])
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
