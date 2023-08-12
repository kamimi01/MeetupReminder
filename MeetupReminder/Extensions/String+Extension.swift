//
//  String+Extension.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/11.
//

extension String {
    func onlyEmoji() -> String {
        return self.filter({ $0.isEmoji })
    }
}
