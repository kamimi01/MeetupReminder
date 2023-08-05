//
//  FriendDetailViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/03.
//

import Foundation

class FriendDetailViewModel: ObservableObject {
    @Published var nameLabel = ""
    @Published var remarkLabel = ""
    @Published var isTappedLineButton = false
    var cardColor = CardViewColor.blue

    func initialize(person: PersonModel, cardIndex: Int) {
        nameLabel = person.name
        remarkLabel = person.remark
        cardColor = CardColorGenerator.color(with: cardIndex)
    }

    func didTapContactButton(contact with: ContactMethod) {

    }

    func switchReminderToggle() {

    }

    func didTapFriendDeleteButton() {

    }

    func didTapUpdateFriendButton() {

    }
}
