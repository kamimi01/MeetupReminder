//
//  PersonListViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import Foundation

class PersonListViewModel: ObservableObject {
    @Published var personList: [Person] = []

    func onAppear() {
        let realmHelper = RealmHelper()
        let allFriends = realmHelper.loadFriends()
        personList.append(contentsOf: allFriends)
    }
}
