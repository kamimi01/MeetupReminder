//
//  FriendDetailViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/03.
//

import Foundation
import Combine

class FriendDetailViewModel: FriendDetailViewModelProtocol {
    private(set) var objectWillChange = ObservableObjectPublisher()

    private var person = PersonModel()
    @Published var nameLabel = ""
    @Published var remarkLabel = ""
    private(set) var cardColor = CardViewColor.blue
    /// 連絡方法のいずれかが押下された場合に、View を再描画する。
    /// そうすることで、連絡方法のアイコンの画像が切り替わる。
    private var isTappedContactButton = false {
        willSet {
            objectWillChange.send()
        }
    }
    private var isTappedLineButton = false
    private var isTappedFacebookButton = false
    private var isTappedTwitterButton = false
    private var isTappedLinkedinButton = false
    private var isTappedSlackButton = false
    /// Toggle に onChange モディファイアをつけても呼ばれず、View の再描画が行われなかったので、ここで明示的に対応した
    @Published var isOnReminder = false {
        didSet {
            objectWillChange.send()
        }
    }
    @Published var selectedRemindDate = Date()

    private let realmHelper: RealmHelper

    init() {
        realmHelper = RealmHelper.shared
    }

    func initialize(person: PersonModel, cardIndex: Int) {
        self.person = person
        nameLabel = person.name
        remarkLabel = person.remark
        isTappedLineButton = person.canContactWithLINE
        isTappedFacebookButton = person.canContactWithFacebook
        isTappedTwitterButton = person.canContactWithTwitter
        isTappedLinkedinButton = person.canContactWithLinkedIn
        isTappedSlackButton = person.canContactWithSlack

        if let remindDate = person.remindDate {
            isOnReminder = true
            selectedRemindDate = remindDate
        } else {
            isOnReminder = false
            selectedRemindDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        }

        cardColor = CardColorGenerator.color(with: cardIndex)
    }

    func didTapContactButton(contactMethod: ContactMethod) {
        isTappedContactButton.toggle()

        switch contactMethod {
        case .line(_):
            isTappedLineButton.toggle()
        case .facebook(_):
            isTappedFacebookButton.toggle()
        case .twitter(_):
            isTappedTwitterButton.toggle()
        case .linkedin(_):
            isTappedLinkedinButton.toggle()
        case .slack(_):
            isTappedSlackButton.toggle()
        }
    }

    func isTappedContactMethodButton(contactMethod: ContactMethod) -> Bool {
        switch contactMethod {
        case .line(_):
            return isTappedLineButton
        case .facebook(_):
            return isTappedFacebookButton
        case .twitter(_):
            return isTappedTwitterButton
        case .linkedin(_):
            return isTappedLinkedinButton
        case .slack(_):
            return isTappedSlackButton
        }
    }

    func didTapFriendDeleteButton(completionHandler: () -> Void) {
        deleteNotification(id: person.id)

        if deleteFriend(id: person.id) {
            completionHandler()
        }
    }

    /// Realm からともだち情報を削除する
    private func deleteFriend(id: String) -> Bool {
        realmHelper.deleteFriend(id: id)
    }

    /// 通知を削除する
    private func deleteNotification(id: String) {
        let userNotificationUtil = UserNotificationUtil.shared
        userNotificationUtil.deleteRequest(id: id)
    }

    func didTapUpdateFriendButton(completionHandler: () -> Void) {
        let remindDate = isOnReminder ? selectedRemindDate : nil
        updateNotification(id: person.id, remindDate: remindDate)

        if updateFriendInfo(id: person.id, remindDate: remindDate) {
            completionHandler()
        }
    }

    /// 通知を更新する
    private func updateNotification(id: String, remindDate: Date?) {
        let userNotificationUtil = UserNotificationUtil.shared
        if let remindDate = remindDate {
            // 通知を更新
            userNotificationUtil.setTimeRequest(id: id, message: NotificationMessage(name: nameLabel), date: remindDate)
        } else {
            // 通知を削除
            userNotificationUtil.deleteRequest(id: id)
        }
    }

    /// Realm のともだち情報を更新する
    private func updateFriendInfo(id: String, remindDate: Date?) -> Bool {
        realmHelper.updateFriend(
            id: id,
            name: nameLabel,
            canContactWithLINE: isTappedLineButton,
            canContactWithFacebook: isTappedFacebookButton,
            canContactWithTwitter: isTappedTwitterButton,
            canContactWithLinkedIn: isTappedLinkedinButton,
            canContactWithSlack: isTappedSlackButton,
            remark: remarkLabel,
            remindDate: remindDate
        )
    }
}
