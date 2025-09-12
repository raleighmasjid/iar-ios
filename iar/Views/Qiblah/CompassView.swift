//
//  CompassView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/13/25.
//

import SwiftUI

struct CompassView: View {
    
    var angle: Double
    var percentCorrect: Double
    
    @State private var showExpandedMessage: Bool = false
    
    var makkahText: AttributedString {
        var text1 = AttributedString("You're Facing ")
        text1.foregroundColor = .primaryText
        var text2 = AttributedString("Makkah")
        text2.foregroundColor = .accent
        return text1 + text2
    }
    
    var accuracyMessage: String {
        if showExpandedMessage {
            return "Compass direction may not be 100% accurate when used inside or near electric or magnetic interference. Please verify with map overlay."
        } else {
            return "Compass direction may not be 100% accurate."
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 32) {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.accent)
                    .opacity(percentCorrect)
                    .animation(.easeInOut(duration: 0.15), value: percentCorrect)
                CompassArrow(angle: angle, percentCorrect: percentCorrect)
            }
        
            Text(makkahText)
                .scalingFont(size: 22, weight: .bold)
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .opacity(percentCorrect)
                .animation(.easeInOut(duration: 0.15), value: percentCorrect)
                .padding(.horizontal, 32)
            Spacer()
            Button {
                withAnimation(.snappy) {
                    showExpandedMessage.toggle()
                }
            } label: {
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: "info.circle.fill")
                    Group {
                        if showExpandedMessage {
                            Text("Compass direction may not be 100% accurate when used indoors or near electric or magnetic interference. Please verify Qibla with the map overlay.")
                        } else {
                            Text("Compass direction may not be 100% accurate")
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .allowsTightening(true)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .scalingFont(size: 13)
                    Image(systemName: "chevron.down")
                        .rotationEffect(Angle(degrees: showExpandedMessage ? 180 : 0))
                        .imageScale(.small)
                        .bold()
                }
            }
            .buttonStyle(PrimaryContainerButtonStyle(size: .large))
            .padding(.top, 32)
            .padding(.bottom, 16)
            .padding(.horizontal, 16)
        }
    }
}
