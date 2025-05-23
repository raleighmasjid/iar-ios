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
        HStack(spacing: 5) {
            Image(.locationMarker)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: markerHeight)
            Text(locationName ?? "---")
        }
        .scalingFont(size: 15, weight: .medium)
        .lineLimit(1)
        .primaryContainer(size: .small)
    }
}

#if DEBUG
#Preview("Raleigh") {
    LocationCard(locationName: "Raleigh")
}

#Preview("Loading") {
    LocationCard(locationName: nil)
}
#endif
