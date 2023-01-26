//
//  PersonListViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import Foundation

class PersonListViewModel: ObservableObject {
    @Published var personList: [Person] = []
    private let realmHelper: RealmHelper

    init() {
        realmHelper = RealmHelper()
    }

    func onAppear() {
        let allFriends = realmHelper.loadFriends()
        personList.append(contentsOf: allFriends)
    }

    func updateFriend(
        id: String,
        name: String? = nil,
        canContactWithLINE: Bool? = nil,
        canContactWithFacebook: Bool? = nil,
        canContactWithTwitter: Bool? = nil,
        canContactWithLinkedIn: Bool? = nil,
        canContactWithSlack: Bool? = nil,
        remark: String? = nil
    ) {
        realmHelper.updateFriend(
            id: id,
            name: name,
            canContactWithLINE: canContactWithLINE,
            canContactWithFacebook: canContactWithFacebook,
            canContactWithTwitter: canContactWithTwitter,
            canContactWithLinkedIn: canContactWithLinkedIn,
            canContactWithSlack: canContactWithSlack
        )
    }
}
