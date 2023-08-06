//
//  FirebaseAnalyticsHelper.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/06.
//

import Foundation
import FirebaseAnalytics

struct FirebaseAnalyticsHelper: Loggable  {
    func sendLogEvent(screen: Screen) {
        Analytics.logEvent(
            AnalyticsEventScreenView,
            parameters: [
                AnalyticsParameterScreenName: screen.rawValue
            ]
        )
    }
}
