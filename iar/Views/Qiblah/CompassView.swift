//
//  CompassView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/16/24.
//

import SwiftUI

struct CompassView: View {
    
    var angle: Double
    var percentCorrect: Double
    @State var compassSize: CGSize = .zero
    
    var kabahSize: CGFloat {
        round(compassSize.width * 0.26)
    }
    
    var body: some View {
        ZStack {
            Image(.compass)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(.degrees(angle))
                .animation(.easeInOut(duration: 0.15), value: angle)
                .shadow(color: .qiblaGlow.opacity(percentCorrect), radius: 50, x: 0, y: 5)
                .animation(.easeInOut(duration: 0.15), value: percentCorrect)
                .onGeometryChange(for: CGSize.self) { proxy in
                    proxy.size
                } action: { newValue in
                    compassSize = newValue
                }
            Image(.kabah)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: kabahSize, height: kabahSize)
        }
        .padding(.horizontal, 20)
    }
}

#Preview("Incorrect") {
    CompassView(angle: 45, percentCorrect: 0)
}

#Preview("Correct") {
    CompassView(angle: 0, percentCorrect: 0.5)
}
