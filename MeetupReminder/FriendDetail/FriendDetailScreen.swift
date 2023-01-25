//
//  FriendDetailScreen.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import SwiftUI

struct FriendDetailScreen: View {
    let cardColor: CardViewColor
    @State private var nameText = "佐藤花子"
    @State private var remarkText = "try! Swiftで会った人。一緒に小籠包を食べた。"

    var body: some View {
        ZStack {
            cardColor.carViewBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                profileImage
                VStack(alignment: .leading) {
                    Text("メモ")
                        .foregroundColor(.mainText)
                        .padding(.horizontal, 5)
                    ZStack {
                        Color.mainBackground
                            .frame(height: 100)
                            .background(Color.mainBackground)
                            .cornerRadius(20)
                        VStack {
                            TextField("", text: $remarkText)
                                .foregroundColor(.mainText)
                                .border(Color.red)
                                .padding()
                            Spacer()
                        }
                        .frame(height: 100)
                    }
                }
                .padding(16)
                Spacer()
            }
        }
    }
}

private extension FriendDetailScreen {
    var profileImage: some View {
        VStack(spacing: 10) {
            Image(cardColor.profileImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.mainBackground)
                .clipShape(Circle())
                .frame(maxWidth: 130, maxHeight: 130)
            TextField("", text: $nameText)
                .frame(width: 150)
                .font(.title2)
                .foregroundColor(.mainText)
                .multilineTextAlignment(.center)
                .border(Color.red)
                .padding(.horizontal, 16)
        }
    }
}

struct FriendDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetailScreen(cardColor: .red)
    }
}
