//
//  PersonListViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import Foundation
import RealmSwift

class PersonListViewModel: ObservableObject {
    @Published var personList: [PersonModel] = []
    private var allFriends: Results<Person>? = nil
    private let realmHelper: RealmHelper
    private var token: NotificationToken?

    init() {
        print("init呼ばれた")
        realmHelper = RealmHelper()
        allFriends = realmHelper.loadFriends()
        token = allFriends?.observe { [weak self] _ in
            print("observe呼ばれた")
            guard let self = self,
                  let allFriendsNotOptional = self.allFriends
            else {
                return
            }
            self.personList = Array(allFriendsNotOptional).map {
                PersonModel(id: $0.id, name: $0.name, canContactWithLINE: $0.canContactWithLINE, canContactWithFacebook: $0.canContactWithFacebook, canContactWithTwitter: $0.canContactWithTwitter, canContactWithLinkedIn: $0.canContactWithLinkedIn, canContactWithSlack: $0.canContactWithSlack, remark: $0.remark)
            }
        }
    }

    deinit {
        token?.invalidate()
    }

    func onAppear() {
        // Realmのオブジェクトを使用すると、Object has been deleted or invalidated. でクラッシュするため、表示するのための別の構造体を用意
//        personList = allFriends.map {
//            PersonModel(id: $0.id, name: $0.name, canContactWithLINE: $0.canContactWithLINE, canContactWithFacebook: $0.canContactWithFacebook, canContactWithTwitter: $0.canContactWithTwitter, canContactWithLinkedIn: $0.canContactWithLinkedIn, canContactWithSlack: $0.canContactWithSlack, remark: $0.remark)
//        }
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
    ) -> Bool {
        return realmHelper.updateFriend(
            id: id,
            name: name,
            canContactWithLINE: canContactWithLINE,
            canContactWithFacebook: canContactWithFacebook,
            canContactWithTwitter: canContactWithTwitter,
            canContactWithLinkedIn: canContactWithLinkedIn,
            canContactWithSlack: canContactWithSlack,
            remark: remark
        )
    }

    func deleteFriend(id: String) -> Bool {
        return realmHelper.deleteFriend(id: id)
    }
}
