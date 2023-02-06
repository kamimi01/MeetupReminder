//
//  ContentView.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PersonListViewModel()
    @State private var isShowingAddFriendScreen = false
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        NavigationView {
            ZStack {
                Color.mainBackground
                    .edgesIgnoringSafeArea(.all)
                if viewModel.personList.isEmpty {
                    Spacer()
                    LottieView(animationType: .friendships)
                        .frame(width: 250, height: 180)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(Array(viewModel.personList.enumerated()), id: \.offset) { personIndex, person in
                                NavigationLink(destination: FriendDetailScreen(viewModel: viewModel, person: person, cardColor: color(index: personIndex))) {
                                    PersonCardView(person: person, cardColor: color(index: personIndex))
                                         .padding(.horizontal, 16)
                                }
                            }
                        }
                    }
                }
                addButton
                    .position(x: UIScreen.main.bounds.width - 70, y: addButtonY)
            }
            .navigationTitle("ともだち")
        }
        .accentColor(.mainText)
        .onAppear {
            viewModel.onAppear()
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
                let userNotificationUtil = UserNotificationUtil.shared
                userNotificationUtil.resetNotification()
            case .inactive:
                print("inactive")
            case .background:
                print("background")
            @unknown default:
                print("do nothing")
            }
        }
    }
}

private extension ContentView {
    var addButton: some View {
        Button(action: {
            isShowingAddFriendScreen = true
        }) {
            Image(systemName: "plus")
                .font(.title)
                .frame(width: 90, height: 90)
                .imageScale(.large)
                .background(Color.cardViewTextRed)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
        }
        .fullScreenCover(isPresented: $isShowingAddFriendScreen) {
            AddFriendScreen()
        }
    }

    var addButtonY: CGFloat {
        // FIXME: 3枚の時だけ、アイコンが押せないのでずらした。UI含めてどうすべきか考え直したい
        if viewModel.personList.count == 3 {
            return UIScreen.main.bounds.height - 240
        } else {
            return UIScreen.main.bounds.height - 270
        }
    }

    // TODO: なんか間違っている気がするので後でみる
    func color(index: Int) -> CardViewColor {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
