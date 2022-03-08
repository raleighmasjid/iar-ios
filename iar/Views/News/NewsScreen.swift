//
//  NewsScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/24/22.
//

import SwiftUI

struct NewsScreen: View {
    
    enum Section: String, CaseIterable, Identifiable {
        case announcements
        case events
        
        var title: String {
            switch self {
            case .announcements:
                return "Announcements"
            case .events:
                return "Events"
            }
        }
        
        var id: String { rawValue }
    }
    
    @State var section: Section = .announcements
    var body: some View {
        VStack {
            Picker("Section", selection: $section) {
                ForEach(Section.allCases) {
                    Text($0.title).tag($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20)

            Text("\(section.title)")
            Spacer(minLength: 10)
        }
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
