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

                Text(fridayPrayer.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 16, weight: .regular))
                    .padding(.vertical, 24)
                
                HStack {
                    Image(uiImage: imageLoader.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 42, height: 42)
                        .background(Color.white)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(fridayPrayer.speaker)
                            .font(.system(size: 16, weight: .semibold))
                        Text(fridayPrayer.description)
                            .font(.system(size: 12, weight: .light))
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .foregroundColor(.white)
            
        }
        .background(
            Image("card-back")
                .resizable(capInsets: EdgeInsets(top: 160,
                                                 leading: 260,
                                                 bottom: 10,
                                                 trailing: 10),
                           resizingMode: .stretch)
        )
        .cornerRadius(8)
        .onAppear {
            imageLoader.update(urlString: fridayPrayer.imageUrl)
        }
        .onChange(of: fridayPrayer.imageUrl) { newValue in
            imageLoader.update(urlString: newValue)
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
