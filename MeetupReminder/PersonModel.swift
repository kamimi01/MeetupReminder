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
    var profileImage: String = ""
    var canContactWithLINE: Bool = false
    var canContactWithFacebook: Bool = false
    var canContactWithTwitter: Bool = false
    var canContactWithLinkedIn: Bool = false
    var canContactWithSlack: Bool = false
    var canContactWithWhatsApp: Bool = false
    var remark: String = ""
    var remindDate: Date? = nil

    mutating func initialize(id: String, profileImage: String, name: String, canContactWithLINE: Bool, canContactWithFacebook: Bool, canContactWithTwitter: Bool, canContactWithLinkedIn: Bool, canContactWithSlack: Bool, canContactWithWhatsApp: Bool, remark: String, remindDate: Date?) {
        self.id = id
        self.name = name
        self.profileImage = profileImage
        self.canContactWithLINE = canContactWithLINE
        self.canContactWithFacebook = canContactWithFacebook
        self.canContactWithTwitter = canContactWithTwitter
        self.canContactWithLinkedIn = canContactWithLinkedIn
        self.canContactWithSlack = canContactWithSlack
        self.canContactWithWhatsApp = canContactWithWhatsApp
        self.remark = remark
        self.remindDate = remindDate
    }
}
