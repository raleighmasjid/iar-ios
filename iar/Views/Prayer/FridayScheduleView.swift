//
//  FridayScheduleView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct FridayScheduleView: View {
    let fridayPrayers: [FridayPrayer]
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Friday Prayers")
                .font(.system(size: 28, weight: .bold))
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
struct FridayScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        FridayScheduleView(fridayPrayers: FridayPrayer.mocks())
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
