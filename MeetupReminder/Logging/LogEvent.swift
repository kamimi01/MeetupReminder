//
//  LogEvent.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/06.
//

import Foundation

enum Screen: String {
    case friendlist = "friendlist"
    case friendupdate = "friendupdate"
    case newfriend = "newfriend"
    case setting = "setting"
}

struct LogEvent {
    let screenName: Screen
}
