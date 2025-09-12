//
//  MapArrow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 8/1/25.
//

import SwiftUI

struct MapArrowGraphic: View {
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Path { path in
                    let size = max(geometry.size.width, geometry.size.height)
                    let midPoint = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    path.move(to: CGPoint(x: midPoint.x - 3, y: midPoint.y))
                    path.addLine(to: CGPoint(x: midPoint.x - 3, y: midPoint.y - size))
                    path.addLine(to: CGPoint(x: midPoint.x + 3, y: midPoint.y - size))
                    path.addLine(to: CGPoint(x: midPoint.x + 3, y: midPoint.y))
                    path.addLine(to: CGPoint(x: midPoint.x - 3, y: midPoint.y))
                }
                .fill(Color.compassOutline)
            }
            Image(.mapArrow)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    MapArrowGraphic()
}
