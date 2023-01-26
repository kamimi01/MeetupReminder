//
//  PersonModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/26.
//

import Foundation

struct PersonModel {
    let id: String
    let name: String
    let canContactWithLINE: Bool
    let canContactWithFacebook: Bool
    let canContactWithTwitter: Bool
    let canContactWithLinkedIn: Bool
    let canContactWithSlack: Bool
    let remark: String
}
