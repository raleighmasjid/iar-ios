//
//  LocationCard.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/13/25.
//

import SwiftUI

struct LocationCard: View {
    
    let locationName: String?
    @ScaledMetric private var markerHeight: Double = 14
    
    var body: some View {
        HStack {
            Image(.locationMarker)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: markerHeight)
            Text(locationName ?? "---")
        }
        .scalingFont(size: 15, weight: .medium)
        .lineLimit(1)
        .foregroundStyle(.accent)
        .padding(12)
        .background(.primaryContainer)
        .cornerRadius(12)
    }
}

#if DEBUG
#Preview {
    LocationCard(locationName: "Raleigh")
}

#Preview {
    LocationCard(locationName: nil)
}
#endif
