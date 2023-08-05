//
//  FriendListViewModelProtocol.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/05.
//

import Foundation

protocol FriendListViewModelProtocol {
    var personList: [PersonModel] { get set }
    var isShowingAppInfoScreen: Bool { get set }
    var isShowingAddFriendScreen: Bool { get set }
    func onAppear()
    func registerNotification(of person: PersonModel, date: Date)
    func didActivate()
    func didTapInfoButton()
    func didTapAddButton()
    func updateFriend(id: String, name: String, canContactWithLINE: Bool, canContactWithFacebook: Bool, canContactWithTwitter: Bool, canContactWithLinkedIn: Bool, canContactWithSlack: Bool, remark: String, remindDate: Date?) -> Bool
    func deleteFriend(id: String) -> Bool
}

extension FriendListViewModelProtocol {
    func updateFriend(id: String, name: String, canContactWithLINE: Bool, canContactWithFacebook: Bool, canContactWithTwitter: Bool, canContactWithLinkedIn: Bool, canContactWithSlack: Bool, remark: String, remindDate: Date? = nil) -> Bool {
        updateFriend(id: id, name: name, canContactWithLINE: canContactWithLINE, canContactWithFacebook: canContactWithFacebook, canContactWithTwitter: canContactWithTwitter, canContactWithLinkedIn: canContactWithLinkedIn, canContactWithSlack: canContactWithSlack, remark: remark, remindDate: remindDate)
    }
}
