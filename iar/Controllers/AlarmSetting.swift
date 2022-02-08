//
//  AlarmSetting.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/5/22.
//

import Foundation
import SwiftUI

protocol AlarmSettingDelegate: AnyObject {
    func didUpdateAlarm()
}

class AlarmSetting: ObservableObject {
    
    static let fajrKey = "fajrNotification"
    static let shuruqKey = "shuruqNotification"
    static let dhuhrKey = "dhuhrNotification"
    static let asrKey = "asrNotification"
    static let maghribKey = "maghribNotification"
    static let ishaKey = "ishaNotification"
    
    weak var delegate: AlarmSettingDelegate?
    
    @AppStorage(AlarmSetting.fajrKey)
    var fajr: Bool = false {
        didSet {
            delegate?.didUpdateAlarm()
        }
    }
    
    @AppStorage(AlarmSetting.shuruqKey)
    var shuruq: Bool = false {
        didSet {
            delegate?.didUpdateAlarm()
        }
    }
    
    @AppStorage(AlarmSetting.dhuhrKey)
    var dhuhr: Bool = false {
        didSet {
            delegate?.didUpdateAlarm()
        }
    }
    
    @AppStorage(AlarmSetting.asrKey)
    var asr: Bool = false {
        didSet {
            delegate?.didUpdateAlarm()
        }
    }
    
    @AppStorage(AlarmSetting.maghribKey)
    var maghrib: Bool = false {
        didSet {
            delegate?.didUpdateAlarm()
        }
    }
    
    @AppStorage(AlarmSetting.ishaKey)
    var isha: Bool = false {
        didSet {
            delegate?.didUpdateAlarm()
        }
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
    
    func boundAlarm(for prayer: Prayer) -> Binding<Bool> {
        Binding(
            get: {
                self.isEnabled(for: prayer)
            },
            set: { newValue in
                switch prayer {
                case .fajr:
                    self.fajr = newValue
                case .shuruq:
                    self.shuruq = newValue
                case .dhuhr:
                    self.dhuhr = newValue
                case .asr:
                    self.asr = newValue
                case .maghrib:
                    self.maghrib = newValue
                case .isha:
                    self.isha = newValue
                }
            }
        )
    }
}
