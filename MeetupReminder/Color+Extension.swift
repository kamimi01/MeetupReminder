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

    // カードビューの背景色
    static let cardViewRed = Color("person_card_color_red")
    static let cardViewGreen = Color("person_card_color_green")
    static let cardViewBlue = Color("person_card_color_blue")
    static let cardViewOrange = Color("person_card_color_orange")
    // カードビューのテキスト色
    static let cardViewTextRed = Color("person_card_color_red_bold")
    static let cardViewTextGreen = Color("person_card_color_green_bold")
    static let cardViewTextBlue = Color("person_card_color_blue_bold")
    static let cardViewTextOrange = Color("person_card_color_orange_bold")
}

enum CardViewColor {
    case red
    case green
    case blue
    case orange

    var carViewBackground: Color {
        switch self {
        case .red:
            return Color.cardViewRed
        case .green:
            return Color.cardViewGreen
        case .blue:
            return Color.cardViewBlue
        case .orange:
            return Color.cardViewOrange
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
        case .orange:
            return Color.cardViewTextOrange
        }
    }
}
