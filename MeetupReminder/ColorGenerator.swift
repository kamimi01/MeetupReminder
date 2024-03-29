//
//  ColorGenerator.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/04.
//

import Foundation

struct CardColorGenerator {
    // TODO: なんか間違っている気がするので後でみる
    static func color(with index: Int) -> CardViewColor {
        let orderOfCard = index + 1

        // 4種類ごとに違う色を使う
        var colorIndex: Int {
            let integer1: Double = (Double(orderOfCard) - 1.0) / 4.0
            let decimal1 = integer1.truncatingRemainder(dividingBy: 1)
            if decimal1.truncatingRemainder(dividingBy: 1).isLess(than: .ulpOfOne) {
                return 1  // 赤
            }

            let integer2: Double = (Double(orderOfCard) - 2.0) / 4.0
            let decimal2 = integer2.truncatingRemainder(dividingBy: 1)
            if decimal2.truncatingRemainder(dividingBy: 1).isLess(than: .ulpOfOne) {
                return 2  // 緑
            }

            let integer3: Double = (Double(orderOfCard) - 3.0) / 4.0
            let decimal3 = integer3.truncatingRemainder(dividingBy: 1)
            if decimal3.truncatingRemainder(dividingBy: 1).isLess(than: .ulpOfOne) {
                return 3  // 黄色
            }

            let integer4: Double = (Double(index) - 4.0) / 4.0
            let decimal4 = integer4.truncatingRemainder(dividingBy: 1)
            if decimal4.truncatingRemainder(dividingBy: 1).isLess(than: .ulpOfOne) {
                return 4  // 青
            }

            return 1 // 赤
        }

        switch colorIndex {
        case 1:
            return CardViewColor.red
        case 2:
            return CardViewColor.green
        case 3:
            return CardViewColor.yellow
        case 4:
            return CardViewColor.blue
        default:
            fatalError("failed to switch")
        }
    }
}
