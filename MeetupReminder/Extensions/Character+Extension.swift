//
//  Character+Extension.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/11.
//

extension Character {
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && (scalar.value > 0x238C || unicodeScalars.count > 1)
    }
}
