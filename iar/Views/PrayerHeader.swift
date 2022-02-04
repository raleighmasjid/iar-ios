//
//  PrayerHeader.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import SwiftUI

struct PrayerHeader: View {
    
    let prayerDay: PrayerDay?
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 2) {
                if let prayerDay = prayerDay {
                    Text(Formatter.dayFormatter.string(from: prayerDay.date))
                    Text(prayerDay.hijri.formatted())
                        .italic()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            HStack() {
                Text("Prayer")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Adhan")
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Iqamah")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.white)
            .background(Color.Theme.darkGreen)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

#if DEBUG
struct PrayerHeader_Previews: PreviewProvider {
    static var previews: some View {
        PrayerHeader(prayerDay: PrayerDay.mock())
            .previewLayout(PreviewLayout.sizeThatFits)
        PrayerHeader(prayerDay: nil)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
#endif
