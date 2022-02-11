//
//  NotificationSettings.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/5/22.
//

import Foundation
import Combine
import SwiftUI

class NotificationSettings: ObservableObject {
    
    private let publisher = PassthroughSubject<Void, Never>()
    
    static let fajrKey = "fajrNotification"
    static let shuruqKey = "shuruqNotification"
    static let dhuhrKey = "dhuhrNotification"
    static let asrKey = "asrNotification"
    static let maghribKey = "maghribNotification"
    static let ishaKey = "ishaNotification"
    
    @AppStorage(NotificationSettings.fajrKey)
    private(set) var fajr: Bool = false
    
    @AppStorage(NotificationSettings.shuruqKey)
    private(set) var shuruq: Bool = false
    
    @AppStorage(NotificationSettings.dhuhrKey)
    private(set) var dhuhr: Bool = false
    
    @AppStorage(NotificationSettings.asrKey)
    private(set) var asr: Bool = false
    
    @AppStorage(NotificationSettings.maghribKey)
    private(set) var maghrib: Bool = false
    
    @AppStorage(NotificationSettings.ishaKey)
    private(set) var isha: Bool = false
    
    var didUpdate: AnyPublisher<Void, Never> {
        publisher.receive(on: RunLoop.main).eraseToAnyPublisher()
    }
    
    func isEnabled(for prayer: Prayer) -> Bool {
        switch prayer {
        case .fajr:
            return fajr
        case .shuruq:
            return shuruq
        case .dhuhr:
            return dhuhr
        case .asr:
            return asr
        case .maghrib:
            return maghrib
        case .isha:
            return isha
        }
    }
    
    func setEnabled(_ enabled: Bool, for prayer: Prayer) {
        switch prayer {
        case .fajr:
            fajr = enabled
        case .shuruq:
            shuruq = enabled
        case .dhuhr:
            dhuhr = enabled
        case .asr:
            asr = enabled
        case .maghrib:
            maghrib = enabled
        case .isha:
            isha = enabled
        }
        publisher.send()
    }
    
    func boundValue(for prayer: Prayer) -> Binding<Bool> {
        Binding(
            get: {
                self.isEnabled(for: prayer)
            },
            set: { newValue in
                self.setEnabled(newValue, for: prayer)
            }
        )
    }
}
