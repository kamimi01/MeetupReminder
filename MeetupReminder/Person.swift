//
//  Person.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import Foundation
import RealmSwift

class Person: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var canContactWithLINE = false
    @objc dynamic var canContactWithFacebook = false
    @objc dynamic var canContactWithTwitter = false
    @objc dynamic var canContactWithLinkedIn = false
    @objc dynamic var canContactWithSlack = false
    @objc dynamic var remark = ""
}
