//
//  SettingViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/06.
//

import Foundation

class SettingViewModel: SettingViewModelProtocol {
    func onAppear() {
        logEvent()
    }

    private func logEvent() {
        let firebaseAnalytics = FirebaseAnalyticsHelper()
        firebaseAnalytics.sendLogEvent(screen: .friendlist)
    }
}
