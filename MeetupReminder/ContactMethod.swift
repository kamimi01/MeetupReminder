//
//  ContactMethod.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/03.
//

import Foundation

enum ContactMethod {
    case line
    case facebook
    case twitter
    case linkedin
    case slack

    var image: String {
        switch self {
        case .line: return "line_icon"
        case .facebook: return "facebook_icon"
        case .twitter: return "twitter_icon"
        case .linkedin: return "linkedin_icon"
        case .slack: return "slack_icon"
        }
    }
}
