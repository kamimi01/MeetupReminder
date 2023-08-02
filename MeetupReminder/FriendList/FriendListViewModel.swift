//
//  PersonListViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import Foundation
import RealmSwift

class FriendListViewModel: ObservableObject {
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
                PersonModel(id: $0.id, name: $0.name, canContactWithLINE: $0.canContactWithLINE, canContactWithFacebook: $0.canContactWithFacebook, canContactWithTwitter: $0.canContactWithTwitter, canContactWithLinkedIn: $0.canContactWithLinkedIn, canContactWithSlack: $0.canContactWithSlack, remark: $0.remark, remindDate: $0.remindDate)
            }
        }
    }

    deinit {
        token?.invalidate()
    }

    func onAppear() {
        setNotification()
    }

    private func setNotification() {
        let notificationUtil = UserNotificationUtil.shared
        notificationUtil.initialize()
        notificationUtil.showPushPermission { result in
            switch result {
            case .success(let isGranted):
                print("isGranted:", isGranted)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func registerNotification(of person: PersonModel, date: Date) {
        let notificationUtil = UserNotificationUtil.shared
        notificationUtil.setTimeRequest(of: person, date: date)
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

    func updateFriend(
        id: String,
        name: String,
        canContactWithLINE: Bool,
        canContactWithFacebook: Bool,
        canContactWithTwitter: Bool,
        canContactWithLinkedIn: Bool,
        canContactWithSlack: Bool,
        remark: String,
        remindDate: Date? = nil
    ) -> Bool {
        // TODO: remindDateがnilの場合は通知を削除したい
        // TODO: remindDateが設定されていたら、過去の通知を削除して新しい通知を設定したい
        let userNotificationUtil = UserNotificationUtil.shared
        if let remindDate = remindDate {
            // 通知を更新
            let person = PersonModel(id: id, name: name, canContactWithLINE: canContactWithLINE, canContactWithFacebook: canContactWithFacebook, canContactWithTwitter: canContactWithTwitter, canContactWithLinkedIn: canContactWithLinkedIn, canContactWithSlack: canContactWithSlack, remark: remark, remindDate: remindDate)
            userNotificationUtil.setTimeRequest(of: person, date: remindDate)
        } else {
            // 通知を削除
            userNotificationUtil.deleteRequest(id: id)
        }
        return realmHelper.updateFriend(
            id: id,
            name: name,
            canContactWithLINE: canContactWithLINE,
            canContactWithFacebook: canContactWithFacebook,
            canContactWithTwitter: canContactWithTwitter,
            canContactWithLinkedIn: canContactWithLinkedIn,
            canContactWithSlack: canContactWithSlack,
            remark: remark,
            remindDate: remindDate
        )
    }

    func deleteFriend(id: String) -> Bool {
        return realmHelper.deleteFriend(id: id)
    }
}
