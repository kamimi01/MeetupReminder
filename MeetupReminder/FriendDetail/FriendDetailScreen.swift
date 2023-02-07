//
//  FriendDetailScreen.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import SwiftUI

struct FriendDetailScreen: View {
    @ObservedObject var viewModel: PersonListViewModel

    let person: PersonModel
    let cardColor: CardViewColor

    @State private var nameText: String
    @State private var remarkText: String
    @State private var isTappedLineButton: Bool
    @State private var isTappedFacebookButton: Bool
    @State private var isTappedTwitterButton: Bool
    @State private var isTappedLinkedInButton: Bool
    @State private var isTappedSlackButton: Bool
    @State private var selectedRemindDate: Date
    @State private var reminderToggleFlag: Bool
    @State private var isShowingReminderSetting = false

    @Environment(\.presentationMode) var presentation
    @FocusState private var isFocused: Bool

    init(viewModel: PersonListViewModel, person: PersonModel, cardColor: CardViewColor) {
        self.viewModel = viewModel
        self.person = person
        self.cardColor = cardColor

        _nameText = State(initialValue: person.name)
        _remarkText = State(initialValue: person.remark)
        _isTappedLineButton = State(initialValue: person.canContactWithLINE)
        _isTappedFacebookButton = State(initialValue: person.canContactWithFacebook)
        _isTappedTwitterButton = State(initialValue: person.canContactWithTwitter)
        _isTappedLinkedInButton = State(initialValue: person.canContactWithLinkedIn)
        _isTappedSlackButton = State(initialValue: person.canContactWithSlack)
        if let remindDate = person.remindDate {
            _selectedRemindDate = State(initialValue: remindDate)
            _reminderToggleFlag = State(initialValue: true)
        } else {
            _selectedRemindDate = State(initialValue: Calendar.current.date(byAdding: .hour, value: 1, to: Date())!)
            _reminderToggleFlag = State(initialValue: false)
        }

        //ナビゲーションバーの背景色の設定
        UINavigationBar.appearance().barTintColor = UIColor(cardColor.carViewBackground)
    }

    var body: some View {
        ZStack {
            cardColor.carViewBackground
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 20) {
                    profileImage
                    VStack(alignment: .leading, spacing: 40) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("メモ")
                                .foregroundColor(.mainText)
                                .padding(.horizontal, 5)
                            TextField("高校の友達。今度ランチに行く。", text: $remarkText, axis: .vertical)
                                .padding()
                                .frame(height : 110.0, alignment: .top)
                                .background(Color.mainBackground)
                                .cornerRadius(20)
                                .focused($isFocused)
                                .onTapGesture {
                                    isFocused = true
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
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("通知設定")
                                    .foregroundColor(.mainText)
                                    .padding(.horizontal, 5)
                                Toggle("", isOn: $reminderToggleFlag)
                                    .toggleStyle(SwitchToggleStyle(tint: cardColor.cardViewText))
                                    .onChange(of: reminderToggleFlag) { _ in
                                        if reminderToggleFlag {
                                            isShowingReminderSetting = true
                                        } else {
                                            isShowingReminderSetting = false
                                        }
                                    }
                                Spacer()
                            }
                            if isShowingReminderSetting {
                                HStack {
                                    DatePicker(
                                        "",
                                        selection: $selectedRemindDate,
                                        displayedComponents: [.date, .hourAndMinute]
                                    )
                                    .labelsHidden()
                                    .accentColor(.mainText)
                                    .environment(\.locale, Locale(identifier: "ja_JP"))
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(16)
                    deleteButton
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    updateButton
                }
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
            TextField("なまえ", text: $nameText)
                .frame(width: 200)
                .font(.title2)
                .foregroundColor(.mainText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
    }

    var deleteButton: some View {
        Button(action: {
            let result = viewModel.deleteFriend(id: person.id)
            if result {
                self.presentation.wrappedValue.dismiss()
            }
        }) {
            Text("ともだちから削除")
                .foregroundColor(cardColor.cardViewText)
                .font(.title3)
                .bold()
        }
        .frame(height: 60)
    }

    var updateButton: some View {
        Button(action: {
            let result = viewModel.updateFriend(
                id: person.id,
                name: nameText,
                canContactWithLINE: isTappedLineButton,
                canContactWithFacebook: isTappedFacebookButton,
                canContactWithTwitter: isTappedTwitterButton,
                canContactWithLinkedIn: isTappedLinkedInButton,
                canContactWithSlack: isTappedSlackButton,
                remark: remarkText
            )
            if result {
                if reminderToggleFlag {
                    viewModel.registerNotification(of: person, date: selectedRemindDate)
                }
                self.presentation.wrappedValue.dismiss()
            }
        }) {
            Text("完了")
                .foregroundColor(.mainText)
        }
    }
}

struct FriendDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetailScreen(viewModel: PersonListViewModel(), person: PersonModel(id: "", name: "名前", canContactWithLINE: true, canContactWithFacebook: true, canContactWithTwitter: true, canContactWithLinkedIn: true, canContactWithSlack: true, remark: "メモ", remindDate: nil), cardColor: .red)
    }
}
