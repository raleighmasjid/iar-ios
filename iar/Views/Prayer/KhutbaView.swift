//
//  KhutbaView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct KhutbaView: View {
    let fridayPrayer: FridayPrayer
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text(fridayPrayer.shift)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.Theme.darkGreen)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .cornerRadius(8)
                    Spacer(minLength: 5)
                    Text(fridayPrayer.time)
                        .font(.system(size: 16, weight: .bold))
                }

                Spacer(minLength: 2)

                Text(fridayPrayer.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(3)
                    .font(.system(size: 16, weight: .regular))

                Spacer(minLength: 2)
                
                HStack {
                    Image(uiImage: imageLoader.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .background(Color.white)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(fridayPrayer.speaker)
                            .font(.system(size: 15, weight: .semibold))
                            .lineLimit(2)
                        Text(fridayPrayer.description)
                            .font(.system(size: 12, weight: .light))
                            .lineLimit(2)
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .foregroundColor(.white)
            .frame(height: 190)
        }
        .background(Color.Theme.darkGreen)
        .cornerRadius(8)
        .padding(.bottom, 40)
        .padding(.horizontal, 20)
        .onAppear {
            imageLoader.update(urlString: fridayPrayer.imageUrl)
        }
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
    }
}
#endif
