//
//  UserDefault+Extension.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/10.
//

import Foundation

extension UserDefaults {
    private enum Key: String {
        case isFirstReminderSetting
    }

    /// 初めての通知設定かどうか
    var isFirstReminderSetting: Bool {
        get {
            bool(forKey: Key.isFirstReminderSetting.rawValue)
        }
        set(newValue) {
            set(newValue, forKey: Key.isFirstReminderSetting.rawValue)
        }
    }
}
