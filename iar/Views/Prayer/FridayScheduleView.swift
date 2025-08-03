//
//  FridayScheduleView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct FridayScheduleView: View {
    let fridayPrayers: [FridayPrayer]
    
    func shifts(for campus: Campus) -> [FridayPrayer] {
        fridayPrayers
            .filter { $0.campus == campus }
            .sorted(comparingKeyPath: \.shift)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            ForEach(Campus.allCases, id: \.self) { campus in
                VStack(alignment: .leading, spacing: 16) {
                    let shifts = shifts(for: campus)
                    if !shifts.isEmpty {
                        Text("Jummah @ \(campus.name)")
                            .scalingFont(size: 28, weight: .semibold)
                    }
                    ForEach(shifts, id: \.self) {
                        KhutbaView(fridayPrayer: $0)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    FridayScheduleView(fridayPrayers: FridayPrayer.mocks())
}
#endif
