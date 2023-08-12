//
//  UITextInputMode+Extension.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/13.
//

import UIKit

extension UITextInputMode {
    var canShowEmojiKeyboard: Bool {
        for mode in UITextInputMode.activeInputModes where mode.primaryLanguage == "emoji" {
            return true
        }
        return false
    }
}
