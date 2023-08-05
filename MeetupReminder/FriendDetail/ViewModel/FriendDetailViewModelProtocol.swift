//
//  FriendDetailViewModelProtocol.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/05.
//

import Foundation

protocol FriendDetailViewModelProtocol: ObservableObject {
    var nameLabel: String { get set }
    var remarkLabel: String { get set }
    var cardColor: CardViewColor { get }
    var isOnReminder: Bool { get set }
    var selectedRemindDate: Date { get set }
    func initialize(person: PersonModel, cardIndex: Int)
    func didTapContactButton(contactMethod: ContactMethod)
    func isTappedContactMethodButton(contactMethod: ContactMethod) -> Bool
    func didTapFriendDeleteButton(completionHandler: () -> Void)
    func didTapUpdateFriendButton(completionHandler: () -> Void)
}
