//
//  PrimaryContainer.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 4/22/25.
//

import SwiftUI

struct PrimaryContainer: ViewModifier {
    
    let size: Size
    
    enum Size {
        case small, medium, large
        
        var cornerRadius: CGFloat {
            switch self {
            case .small:
                return 12
            case .medium:
                return 12
            case .large:
                return 16
            }
        }
        
        var padding: EdgeInsets {
            switch self {
            case .small:
                return .init(top: 8, leading: 12, bottom: 8, trailing: 12)
            case .medium:
                return .init(top: 16, leading: 16, bottom: 16, trailing: 16)
            case .large:
                return .init(top: 16, leading: 16, bottom: 16, trailing: 16)
            }
        }
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.accent)
            .padding(size.padding)
            .background(.primaryContainer)
            .cornerRadius(size.cornerRadius)
    }
}

extension View {
    func primaryContainer(size: PrimaryContainer.Size) -> some View {
        modifier(PrimaryContainer(size: size))
    }
}
