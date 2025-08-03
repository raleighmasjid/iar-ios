//
//  MapArrow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 8/1/25.
//

import SwiftUI

struct MapArrow: View {
    
    @Binding
    var direction: Double
    
    @State
    var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            MapArrowGraphic()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .rotationEffect(Angle(degrees: rotationAngle))
            Image(.mapKaaba)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .clipped()
        .onAppear() {
            self.rotationAngle = self.direction
        }
        .onChange(of: direction) { _, newValue in
            withAnimation(.snappy) {
                self.rotationAngle = CompassAngle.adjustedEnd(from: self.rotationAngle, to: newValue)
            }
        }
    }
}
