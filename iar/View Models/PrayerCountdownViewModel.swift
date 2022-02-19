//
//  PrayerCountdownViewModel.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/18/22.
//

import Foundation

class PrayerCountdownViewModel: ObservableObject {
    @Published var upcoming: PrayerTime?
    @Published var timeRemaining: TimeInterval
    
    weak var timer: Timer?
    
    init(upcoming: PrayerTime?) {
        self.upcoming = upcoming
        self.timeRemaining = upcoming?.timeRemaining ?? 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTimeRemaining()
            
        }
    }
    
    func updateTimeRemaining() {
        if let upcoming = upcoming {
            timeRemaining = upcoming.timeRemaining
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}


