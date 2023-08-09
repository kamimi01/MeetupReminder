//
//  AddFriendViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/26.
//

import Foundation

class NewFriendViewModel: ObservableObject {
    func addFriend(personList: [PersonModel]) {}

    func onAppear() {
        logEvent()
    }

    private func logEvent() {
        let firebaseAnalytics = FirebaseAnalyticsHelper()
        firebaseAnalytics.sendLogEvent(screen: .newfriend)
    }
}
