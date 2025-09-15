//
//  Color+Extension.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import Foundation
import SwiftUI

extension Color {
    static let mainText = Color("main_text_color")
    static let mainBackground = Color("main_background_color")

    // カードビューの背景色
    static let cardViewBackground = Color("main_card_background_color")

    // カードビューの左端の色
    static let cardViewRed = Color("person_card_color_red")
    static let cardViewGreen = Color("person_card_color_green")
    static let cardViewBlue = Color("person_card_color_blue")
    static let cardViewYellow = Color("person_card_color_yellow")
    // カードビューのテキスト色
    static let cardViewTextRed = Color("person_card_color_red_bold")
    static let cardViewTextGreen = Color("person_card_color_green_bold")
    static let cardViewTextBlue = Color("person_card_color_blue_bold")
    static let cardViewTextYellow = Color("person_card_color_yellow_bold")
}

enum CardViewColor {
    case red
    case green
    case blue
    case yellow

    var cardViewBackground: Color {
        switch self {
        case .red:
            return Color.cardViewRed
        case .green:
            return Color.cardViewGreen
        case .blue:
            return Color.cardViewBlue
        case .yellow:
            return Color.cardViewYellow
        }
    }

    var cardViewText: Color {
        switch self {
        case .red:
            return Color.cardViewTextRed
        case .green:
            return Color.cardViewTextGreen
        case .blue:
            return Color.cardViewTextBlue
        case .yellow:
            return Color.cardViewTextYellow
        }
    }

    var profileImage: String {
        switch self {
        case .red:
            return "profile_red"
        case .green:
            return "profile_green"
        case .blue:
            return "profile_blue"
        case .yellow:
            return "profile_yellow"
        }
    }

    var lineImageFill: String {
        switch self {
        case .red:
            return "line_icon_red"
        case .green:
            return "line_icon_green"
        case .blue:
            return "line_icon_blue"
        case .yellow:
            return "line_icon_yellow"
        }
    }

    var facebookImageFill: String {
        switch self {
        case .red:
            return "facebook_icon_red"
        case .green:
            return "facebook_icon_green"
        case .blue:
            return "facebook_icon_blue"
        case .yellow:
            return "facebook_icon_yellow"
        }
    }

    var twitterImageFill: String {
        switch self {
        case .red:
            return "twitter_icon_red"
        case .green:
            return "twitter_icon_green"
        case .blue:
            return "twitter_icon_blue"
        case .yellow:
            return "twitter_icon_yellow"
        }
    }

    var linkedinImageFill: String {
        switch self {
        case .red:
            return "linkedin_icon_red"
        case .green:
            return "linkedin_icon_green"
        case .blue:
            return "linkedin_icon_blue"
        case .yellow:
            return "linkedin_icon_yellow"
        }
    }

    var slackImageFill: String {
        switch self {
        case .red:
            return "slack_icon_red"
        case .green:
            return "slack_icon_green"
        case .blue:
            return "slack_icon_blue"
        case .yellow:
            return "slack_icon_yellow"
        }
    }
}
