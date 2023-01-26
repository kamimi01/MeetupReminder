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
        let person1 = Person()
        person1.name = "加藤花子"
        person1.canContactWithLINE = false
        person1.canContactWithFacebook = false
        person1.canContactWithTwitter = false
        person1.canContactWithLinkedIn = true
        person1.canContactWithSlack = false
        person1.remark = "try! Swiftで会った。iOSエンジニアとしては珍しく女性なので定期的に連絡を取りたい。"
        personList.append(person1)
        personList.append(person1)
        personList.append(person1)
        personList.append(person1)
        personList.append(person1)
        personList.append(person1)
        personList.append(person1)
        personList.append(person1)
        personList.append(person1)
    }
}
