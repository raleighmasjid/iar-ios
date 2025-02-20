//
//  FridayScheduleView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct FridayScheduleView: View {
    let fridayPrayers: [FridayPrayer]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Friday Prayers")
                .scalingFont(size: 28, weight: .bold)
                .padding(.horizontal, 20)
            VStack(spacing: 16) {
                ForEach(fridayPrayers, id: \.self) {
                    KhutbaView(fridayPrayer: $0)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 16)
        .padding(.top, 32)
    }
}

#if DEBUG
#Preview {
    FridayScheduleView(fridayPrayers: FridayPrayer.mocks())
}
#endif
