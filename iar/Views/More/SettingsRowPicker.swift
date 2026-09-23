//
//  SettingsRowPicker.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/16/25.
//

import SwiftUI

struct SettingsRowPicker<Option: Hashable & CaseIterable>: View where Option.AllCases: RandomAccessCollection {
    
    let image: Image
    let title: String
    @Binding var selection: Option
    let optionTitle: (Option) -> String
    
    var body: some View {
        HStack {
            HStack(spacing: 16) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.accent)
                    .frame(width: 18, height: 18)
                Text(title)
                    .scalingFont(size: 16)
                    .foregroundStyle(.primaryText)
            }
            Spacer()
            Picker(title, selection: $selection) {
                ForEach(Option.allCases, id: \.self) { option in
                    Text(optionTitle(option)).tag(option)
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
            .tint(.accent)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
        .alignmentGuide(.listRowSeparatorLeading) { _ in 16 }
    }
}

#Preview {
    List {
        SettingsRowPicker(
            image: Image(.adhanSoundIcon),
            title: "Adhan Sound",
            selection: .constant(NotificationType.saadAlghamidi)
        ) { $0.title }
    }
    .listStyle(.plain)
    .scrollContentBackground(.hidden)
    .background(.appBackground)
}
