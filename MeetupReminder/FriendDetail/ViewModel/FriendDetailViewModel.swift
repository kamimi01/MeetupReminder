//
//  FriendDetailViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/03.
//

import Foundation
import Combine

class FriendDetailViewModel: ObservableObject {
    private(set) var objectWillChange = ObservableObjectPublisher()

    @Published var nameLabel = ""
    @Published var remarkLabel = ""
    var cardColor = CardViewColor.blue
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

    func switchReminderToggle() {

    }

    func didTapFriendDeleteButton() {

    }

    func didTapUpdateFriendButton(id: String, remindDate: Date? = nil, completionHandler: () -> Void) {
        updateNotification(id: id, remindDate: remindDate)

        if updateFriendInfo(id: id, remindDate: remindDate) {
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
