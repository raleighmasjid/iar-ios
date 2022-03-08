//
//  FridayScheduleView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct FridayScheduleView: View {
    let fridayPrayers: [FridayPrayer]
    @State var selectedShift: String = ""
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Friday Prayers")
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 20)
            if !fridayPrayers.isEmpty {
                TabView(selection: $selectedShift) {
                    ForEach(fridayPrayers, id: \.self) {
                        KhutbaView(fridayPrayer: $0)
                            .tag($0.shift)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .id(fridayPrayers.hashValue)
                .frame(height: 230)
            }
        }
        .padding(.top, 20)
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background:
                if let firstShift = fridayPrayers.first?.shift {
                    selectedShift = firstShift
                }
            default:
                break
            }
        }
        
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
