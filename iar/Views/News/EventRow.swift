//
//  EventRow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/13/22.
//

import SwiftUI

struct EventRow: View {
    let event: Event
    let startTime: String
    let endTime: String
    
    init(event: Event) {
        self.event = event
        self.startTime = Formatter.timeFormatter.string(from: event.start)
        self.endTime = Formatter.timeFormatter.string(from: event.end)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(event.title)
                .font(.system(size: 16, weight: .semibold))
                .lineLimit(2)
            
            HStack {
                Text("\(startTime) - \(endTime)")
                    
                if (event.repeating) {
                    Image(systemName: "repeat")
                }
            }
            .font(.system(size: 14.0))
            .foregroundColor(.Theme.secondaryText)
            
            Text(event.description)
                .font(.system(size: 12))
                .lineLimit(3)
                .foregroundColor(.Theme.tertiaryText)
            if #available(iOS 15.0, *) {
                Divider()
            }
        }
        .padding(.top, 8)
        .padding(.leading, 16)
    }
}

#if DEBUG
struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(event: News.mocks().events.first!)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
