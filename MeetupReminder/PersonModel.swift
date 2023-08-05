//
//  PersonModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/26.
//

import Foundation

struct PersonModel {
    var id: String = ""
    var name: String = ""
    var canContactWithLINE: Bool = false
    var canContactWithFacebook: Bool = false
    var canContactWithTwitter: Bool = false
    var canContactWithLinkedIn: Bool = false
    var canContactWithSlack: Bool = false
    var remark: String = ""
    var remindDate: Date? = nil

    mutating func initialize(id: String, name: String, canContactWithLINE: Bool, canContactWithFacebook: Bool, canContactWithTwitter: Bool, canContactWithLinkedIn: Bool, canContactWithSlack: Bool, remark: String, remindDate: Date?) {
        self.id = id
        self.name = name
        self.canContactWithLINE = canContactWithLINE
        self.canContactWithFacebook = canContactWithFacebook
        self.canContactWithTwitter = canContactWithTwitter
        self.canContactWithLinkedIn = canContactWithLinkedIn
        self.canContactWithSlack = canContactWithSlack
        self.remark = remark
        self.remindDate = remindDate
    }
}
