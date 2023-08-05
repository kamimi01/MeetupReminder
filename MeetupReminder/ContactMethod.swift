//
//  ContactMethod.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/03.
//

import Foundation

enum ContactMethod: Hashable {
    static func allCases(color: CardViewColor) -> [ContactMethod] {
        [.line(color), .facebook(color), .twitter(color), .linkedin(color), .slack(color)]
    }

    case line(CardViewColor)
    case facebook(CardViewColor)
    case twitter(CardViewColor)
    case linkedin(CardViewColor)
    case slack(CardViewColor)

    var deselectImage: String {
        switch self {
        case .line: return "line_icon"
        case .facebook: return "facebook_icon"
        case .twitter: return "twitter_icon"
        case .linkedin: return "linkedin_icon"
        case .slack: return "slack_icon"
        }
    }

    var selectImage: String {
        switch self {
        case .line(let color):
            switch color {
            case .red: return "line_icon_red"
            case .green: return "line_icon_green"
            case .blue: return "line_icon_blue"
            case .yellow: return "line_icon_yellow"
            }
        case .facebook(let color):
            switch color {
            case .red: return "facebook_icon_red"
            case .green: return "facebook_icon_green"
            case .blue: return "facebook_icon_blue"
            case .yellow: return "facebook_icon_yellow"
            }
        case .twitter(let color):
            switch color {
            case .red: return "twitter_icon_red"
            case .green: return "twitter_icon_green"
            case .blue: return "twitter_icon_blue"
            case .yellow: return "twitter_icon_yellow"
            }
        case .linkedin(let color):
            switch color {
            case .red: return "linkedin_icon_red"
            case .green: return "linkedin_icon_green"
            case .blue: return "linkedin_icon_blue"
            case .yellow: return "linkedin_icon_yellow"
            }
        case .slack(let color):
            switch color {
            case .red: return "slack_icon_red"
            case .green: return "slack_icon_green"
            case .blue: return "slack_icon_blue"
            case .yellow: return "slack_icon_yellow"
            }
        }
    }
}
