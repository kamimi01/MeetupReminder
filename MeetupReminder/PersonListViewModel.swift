//
//  PersonListViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import Foundation

class PersonListViewModel: ObservableObject {
    @Published var personList: [PersonModel] = []
    private let realmHelper: RealmHelper

    init() {
        realmHelper = RealmHelper()
    }

    func onAppear() {
        let allFriends = realmHelper.loadFriends()
//        personList.append(contentsOf: allFriends)

        // Realmのオブジェクトを使用すると、Object has been deleted or invalidated. でクラッシュするため、表示するのための別の構造体を用意
        personList = allFriends.map {
            PersonModel(id: $0.id, name: $0.name, canContactWithLINE: $0.canContactWithLINE, canContactWithFacebook: $0.canContactWithFacebook, canContactWithTwitter: $0.canContactWithTwitter, canContactWithLinkedIn: $0.canContactWithLinkedIn, canContactWithSlack: $0.canContactWithSlack, remark: $0.remark)
        }
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

    func deleteFriend(id: String) {
        realmHelper.deleteFriend(id: id)
    }
}
