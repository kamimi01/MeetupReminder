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

    func initialize(person: PersonModel) {
        nameLabel = person.name
        remarkLabel = person.remark
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
