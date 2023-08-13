//
//  NewFriendViewModelProtocol.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/14.
//

import Foundation
import EmojiPicker

protocol NewFriendViewModeProtocol: ObservableObject {
    var nameLabel: String { get set }
    var remarkLabel: String { get set }
    var profileEmoji: Emoji? { get set }
    var cardColor: CardViewColor { get }
    func onAppear()
    func didTapContactButton(contactMethod: ContactMethod)
    func isTappedContactMethodButton(contactMethod: ContactMethod) -> Bool
    var isShowingAddAlert: Bool { get set }
    func didTapAddButton(completionHandler: () -> Void)
}
