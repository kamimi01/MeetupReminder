//
//  Person.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import Foundation

struct Person: Identifiable {
    let id = UUID().uuidString
    let name: String
    let canContactWithLINE: Bool
    let canContactWithFacebook: Bool
    let canContactWithTwitter: Bool
    let canContactWithLinkedIn: Bool
    let canContactWithSlack: Bool
    let remark: String
//    let profileImage
}
