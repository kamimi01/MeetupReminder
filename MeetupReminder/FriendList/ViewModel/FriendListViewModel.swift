//
//  PersonListViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import Foundation
import RealmSwift
import FirebaseAnalytics

class FriendListViewModel: FriendListViewModelProtocol {

    @Published var personList: [PersonModel] = []
    private var allFriends: Results<Person>? = nil
    private let realmHelper: RealmHelper
    private var token: NotificationToken?
    @Published var isShowingAppInfoScreen = false
    @Published var isShowingAddFriendScreen = false

    init() {
        print("init呼ばれた")
        realmHelper = RealmHelper.shared
        allFriends = realmHelper.loadFriends()
        token = allFriends?.observe { [weak self] _ in
            print("observe呼ばれた")
            guard let self = self,
                  let allFriendsNotOptional = self.allFriends
            else {
                return
            }
            self.personList = Array(allFriendsNotOptional).map {
                var person = PersonModel()
                person.initialize(
                    id: $0.id,
                    profileImage: $0.profileImage,
                    name: $0.name,
                    canContactWithLINE: $0.canContactWithLINE,
                    canContactWithFacebook: $0.canContactWithFacebook,
                    canContactWithTwitter: $0.canContactWithTwitter,
                    canContactWithLinkedIn: $0.canContactWithLinkedIn,
                    canContactWithSlack: $0.canContactWithSlack,
                    canContactWithWhatsApp: $0.canContactWithWhatsApp,
                    remark: $0.remark,
                    remindDate: $0.remindDate
                )
                return person
            }
        }
    }

    deinit {
        token?.invalidate()
    }

    func onAppear() {
        logEvent()
    }

    private func logEvent() {
        let firebaseAnalytics = FirebaseAnalyticsHelper()
        firebaseAnalytics.sendLogEvent(screen: .friendlist)
    }

    func didActivate() {
        let userNotificationUtil = UserNotificationUtil.shared
        userNotificationUtil.resetNotification()
    }

    func didTapInfoButton() {
        isShowingAppInfoScreen = true
    }

    func didTapAddButton() {
        isShowingAddFriendScreen = true
    }
}
