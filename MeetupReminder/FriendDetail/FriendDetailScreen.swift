//
//  FriendDetailScreen.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import SwiftUI

struct FriendDetailScreen: View {
    let cardColor: CardViewColor

    var body: some View {
        ZStack {
            Color.mainBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(cardColor.carViewBackground)
                        .frame(height: UIScreen.main.bounds.height / 2.5)
                    profileImage
                }
                .edgesIgnoringSafeArea(.all)
                Spacer()
            }
        }
    }
}

private extension FriendDetailScreen {
    var profileImage: some View {
        Image(cardColor.profileImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(Color.mainBackground)
            .clipShape(Circle())
            .frame(maxWidth: 130, maxHeight: 130)
    }
}

struct FriendDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetailScreen(cardColor: .red)
    }
}
