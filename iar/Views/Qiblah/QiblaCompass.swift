//
//  Untitled.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/13/25.
//

import SwiftUI

struct QiblaCompass: View {
    
    var angle: Double
    var percentCorrect: Double
    
    var makkahText: AttributedString {
        var text1 = AttributedString("You're Facing ")
        text1.foregroundColor = .primaryText
        var text2 = AttributedString("Makkah")
        text2.foregroundColor = .accent
        return text1 + text2
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 32) {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.accent)
                    .opacity(percentCorrect)
                    .animation(.easeInOut(duration: 0.15), value: percentCorrect)
                CompassStar(angle: angle, percentCorrect: percentCorrect)
            }
        
            Text(makkahText)
                .scalingFont(size: 22, weight: .bold)
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .opacity(percentCorrect)
                .animation(.easeInOut(duration: 0.15), value: percentCorrect)
                .padding(.horizontal, 32)
        }
    }
}
