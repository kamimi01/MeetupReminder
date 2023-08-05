//
//  NotificationMessageGenerator.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/05.
//

import Foundation

struct NotificationMessage {
    private(set) var body = ""

    init(name: String) {
        self.body = "\(name) さんに連絡してみませんか？👀"
    }
}
