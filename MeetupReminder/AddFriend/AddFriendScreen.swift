//
//  AddFriendScreen.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import SwiftUI

struct AddFriendScreen: View {
    let cardColor = CardViewColor.red

    @State private var nameText = ""
    @State private var remarkText = ""
    @State private var isTappedLineButton = false
    @State private var isTappedFacebookButton = false
    @State private var isTappedTwitterButton = false
    @State private var isTappedLinkedInButton = false
    @State private var isTappedSlackButton = false

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                cardColor.carViewBackground
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        profileImage
                        VStack(alignment: .leading, spacing: 40) {
                            VStack(alignment: .leading, spacing: 5) {
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
                                            .padding()
                                        Spacer()
                                    }
                                    .frame(height: 100)
                                }
                            }
                            VStack(alignment: .leading, spacing: 20) {
                                Text("連絡方法")
                                    .foregroundColor(.mainText)
                                    .padding(.horizontal, 5)
                                HStack(spacing: 20) {
                                    Spacer()
                                    Button(action: {
                                        isTappedLineButton.toggle()
                                    }) {
                                        if isTappedLineButton {
                                            Image(cardColor.lineImageFill)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 70, maxHeight: 70)
                                        } else {
                                            Image("line_icon")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 70, maxHeight: 70)
                                        }
                                    }
                                    Button(action: {
                                        isTappedFacebookButton.toggle()
                                    }) {
                                        if isTappedFacebookButton {
                                            Image(cardColor.facebookImageFill)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 70, maxHeight: 70)
                                        } else {
                                            Image("facebook_icon")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 70, maxHeight: 70)
                                        }
                                    }
                                    Button(action: {
                                        isTappedTwitterButton.toggle()
                                    }) {
                                        if isTappedTwitterButton {
                                            Image(cardColor.twitterImageFill)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 70, maxHeight: 70)
                                        } else {
                                            Image("twitter_icon")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 70, maxHeight: 70)
                                        }
                                    }
                                    Spacer()
                                }
                                HStack(spacing: 20) {
                                    Spacer()
                                    Button(action: {
                                        isTappedLinkedInButton.toggle()
                                    }) {
                                        if isTappedLinkedInButton {
                                            Image(cardColor.linkedinImageFill)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 70, maxHeight: 70)
                                        } else {
                                            Image("linkedin_icon")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 70, maxHeight: 70)
                                        }
                                    }
                                    Button(action: {
                                        isTappedSlackButton.toggle()
                                    }) {
                                        if isTappedSlackButton {
                                            Image(cardColor.slackImageFill)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 70, maxHeight: 70)
                                        } else {
                                            Image("slack_icon")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 70, maxHeight: 70)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .padding(16)
                        Spacer()
                    }
                }
            }
            .navigationTitle("新しいともだち")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    dismissButton
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    addButton
                }
            }
        }
    }
}

private extension AddFriendScreen {
    var profileImage: some View {
        VStack(spacing: 10) {
            Image(cardColor.profileImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.mainBackground)
                .clipShape(Circle())
                .frame(maxWidth: 130, maxHeight: 130)
            TextField("", text: $nameText, prompt: Text("なまえ"))
                .frame(width: 150)
                .font(.title2)
                .foregroundColor(.mainText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
    }

    var dismissButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "multiply")
                .foregroundColor(.mainText)
        }
    }

    var addButton: some View {
        Button(action: {
            
        }) {
            Text("追加")
                .foregroundColor(.mainText)
        }
    }
}

struct AddFriendScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendScreen()
    }
}
