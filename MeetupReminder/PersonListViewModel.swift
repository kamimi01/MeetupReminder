//
//  PersonListViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import Foundation

class PersonListViewModel: ObservableObject {
    @Published var personList = [Person(name: "加藤花子", canContactWithLINE: true, canContactWithFacebook: true, canContactWithTwitter: true, canContactWithLinkedIn: true, canContactWithSlack: true, remark: "try! Swiftで会った。iOSエンジニアとしては珍しく女性なので定期的に連絡を取りたい。"), Person(name: "加藤花子", canContactWithLINE: true, canContactWithFacebook: true, canContactWithTwitter: true, canContactWithLinkedIn: true, canContactWithSlack: true, remark: "try! Swiftで会った。iOSエンジニアとしては珍しく女性なので定期的に連絡を取りたい。"), Person(name: "加藤花子", canContactWithLINE: true, canContactWithFacebook: true, canContactWithTwitter: true, canContactWithLinkedIn: true, canContactWithSlack: true, remark: "try! Swiftで会った。iOSエンジニアとしては珍しく女性なので定期的に連絡を取りたい。"), Person(name: "加藤花子", canContactWithLINE: true, canContactWithFacebook: true, canContactWithTwitter: true, canContactWithLinkedIn: true, canContactWithSlack: true, remark: "try! Swiftで会った。iOSエンジニアとしては珍しく女性なので定期的に連絡を取りたい。")]
}
