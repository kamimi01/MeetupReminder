//
//  ContentView.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/24.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var viewModel = PersonListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(Array(viewModel.personList.enumerated()), id: \.offset) { personIndex, person in
                       PersonCardView(person: person, cardColor: color(index: personIndex))
                            .padding(.horizontal, 16)
                    }
                }
            }
            .navigationTitle("ともだち")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension ContentView {
    // TODO: なんか間違っている気がするので後でみる
    func color(index: Int) -> Color {
        let orderOfCard = index + 1

        // 4種類ごとに違う色を使う。1つ目のカードの場合。
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

            let integer3: Double = (Double(orderOfCard) - 2.0) / 4.0
            let decimal3 = integer3.truncatingRemainder(dividingBy: 1)
            if decimal3.truncatingRemainder(dividingBy: 1).isLess(than: .ulpOfOne) {
                return 3  // オレンジ
            }

            let integer4: Double = (Double(index) - 2.0) / 4.0
            let decimal4 = integer4.truncatingRemainder(dividingBy: 1)
            if decimal4.truncatingRemainder(dividingBy: 1).isLess(than: .ulpOfOne) {
                return 4  // 青
            }

            return 1 // 赤
        }

        switch colorIndex {
        case 1:
            return Color.cardViewRed
        case 2:
            return Color.cardViewGreen
        case 3:
            return Color.cardViewOrange
        case 4:
            return Color.cardViewBlue
        default:
            fatalError("failed to switch")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
