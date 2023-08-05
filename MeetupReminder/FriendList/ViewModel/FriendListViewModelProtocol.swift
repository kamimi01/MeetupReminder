//
//  FriendListViewModelProtocol.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/05.
//

import Foundation

protocol FriendListViewModelProtocol: ObservableObject {
    var personList: [PersonModel] { get set }
    var isShowingAppInfoScreen: Bool { get set }
    var isShowingAddFriendScreen: Bool { get set }
    func onAppear()
    func didActivate()
    func didTapInfoButton()
    func didTapAddButton()
}
