//
//  AddFriendViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/26.
//

import Foundation
import Combine
import RealmSwift
import EmojiPicker

class NewFriendViewModel: NewFriendViewModeProtocol {
    private(set) var objectWillChange = ObservableObjectPublisher()

    @Published var nameLabel = ""
    @Published var remarkLabel = ""
    @Published var profileEmoji: Emoji? = Emoji(value: "🙂", name: "Slightly Smile Face") {
        didSet {
            print("emoji:", profileEmoji?.value)
        }
    }
    private(set) var cardColor = CardViewColor.red
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

    func onAppear() {
        logEvent()
    }

    private func logEvent() {
        let firebaseAnalytics = FirebaseAnalyticsHelper()
        firebaseAnalytics.sendLogEvent(screen: .newfriend)
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

    func didTapAddButton(completionHandler: () -> Void) {
        let result = addFriend()
        if result {
            completionHandler()
        }
    }

    private func addFriend() -> Bool{
        let person = Person()
        person.name = nameLabel
        person.profileImage = profileEmoji?.value ?? "🫥"
        person.canContactWithLINE = isTappedLineButton
        person.canContactWithFacebook = isTappedFacebookButton
        person.canContactWithTwitter = isTappedTwitterButton
        person.canContactWithLinkedIn = isTappedLinkedinButton
        person.canContactWithSlack = isTappedSlackButton
        person.remark = remarkLabel

        let realmHelper = RealmHelper.shared
        return realmHelper.addFriend(person: person)
    }
}
