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
    var fajr: Bool = false
    
    @AppStorage(AlarmSetting.shuruqKey)
    var shuruq: Bool = false
    
    @AppStorage(AlarmSetting.dhuhrKey)
    var dhuhr: Bool = false
    
    @AppStorage(AlarmSetting.asrKey)
    var asr: Bool = false
    
    @AppStorage(AlarmSetting.maghribKey)
    var maghrib: Bool = false
    
    @AppStorage(AlarmSetting.ishaKey)
    var isha: Bool = false
    
    func isEnabled(prayer: Prayer) -> Binding<Bool> {
        switch prayer {
        case .fajr:
            return $fajr
        case .shuruq:
            return $shuruq
        case .dhuhr:
            return $dhuhr
        case .asr:
            return $asr
        case .maghrib:
            return $maghrib
        case .isha:
            return $isha
        }
    }

    func didUpdate() {
        delegate?.didUpdateAlarm()
    }
}
