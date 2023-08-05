//
//  FriendDetailScreen.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import SwiftUI

struct FriendDetailScreen<ViewModel: FriendListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject private var detailViewModel = FriendDetailViewModel()

    let person: PersonModel

    @State private var isTappedLineButton: Bool
    @State private var isTappedFacebookButton: Bool
    @State private var isTappedTwitterButton: Bool
    @State private var isTappedLinkedInButton: Bool
    @State private var isTappedSlackButton: Bool
    @State private var selectedRemindDate: Date
    @State private var reminderToggleFlag: Bool
    @State private var isShowingReminderSetting = false
    let minimumRemindDate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!

    @Environment(\.presentationMode) var presentation
    @FocusState private var isFocused: Bool

    init(viewModel: ViewModel, person: PersonModel, cardIndex: Int) {
        self.viewModel = viewModel
        self.person = person

        _isTappedLineButton = State(initialValue: person.canContactWithLINE)
        _isTappedFacebookButton = State(initialValue: person.canContactWithFacebook)
        _isTappedTwitterButton = State(initialValue: person.canContactWithTwitter)
        _isTappedLinkedInButton = State(initialValue: person.canContactWithLinkedIn)
        _isTappedSlackButton = State(initialValue: person.canContactWithSlack)
        if let remindDate = person.remindDate {
            _selectedRemindDate = State(initialValue: remindDate)
            // reminderToggleFlagの変化に合わせてisShowingReminderSettingも変化するように実装されているが、初期化の時だけは連動しないのでここで実装した
            _reminderToggleFlag = State(initialValue: true)
            _isShowingReminderSetting = State(initialValue: true)
        } else {
            _selectedRemindDate = State(initialValue: Calendar.current.date(byAdding: .hour, value: 1, to: Date())!)
            _reminderToggleFlag = State(initialValue: false)
            _isShowingReminderSetting = State(initialValue: false)
        }

        detailViewModel.initialize(person: person, cardIndex: cardIndex)

        //ナビゲーションバーの背景色の設定
        UINavigationBar.appearance().barTintColor = UIColor(detailViewModel.cardColor.carViewBackground)
    }

    var body: some View {
        ZStack {
            detailViewModel.cardColor.carViewBackground
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 20) {
                    profileImage
                    VStack(alignment: .leading, spacing: 40) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("メモ")
                                .foregroundColor(.mainText)
                                .padding(.horizontal, 5)
                            TextField("高校の友達。今度ランチに行く。", text: $detailViewModel.remarkLabel, axis: .vertical)
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
                                        Image(detailViewModel.cardColor.lineImageFill)
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
                                        Image(detailViewModel.cardColor.facebookImageFill)
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
                                        Image(detailViewModel.cardColor.twitterImageFill)
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
                                        Image(detailViewModel.cardColor.linkedinImageFill)
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
                                        Image(detailViewModel.cardColor.slackImageFill)
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
                                    .toggleStyle(SwitchToggleStyle(tint: detailViewModel.cardColor.cardViewText))
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

// MARK: - Private Properties and Methods

private extension FriendDetailScreen {
    var profileImage: some View {
        VStack(spacing: 10) {
            Image(detailViewModel.cardColor.profileImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.mainBackground)
                .clipShape(Circle())
                .frame(maxWidth: 130, maxHeight: 130)
            TextField("なまえ", text: $detailViewModel.nameLabel)
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
            // 通知を削除する
            let userNotificationUtil = UserNotificationUtil.shared
            userNotificationUtil.deleteRequest(id: person.id)

            if result {
                self.presentation.wrappedValue.dismiss()
            }
        }) {
            Text("ともだちから削除")
                .foregroundColor(detailViewModel.cardColor.cardViewText)
                .font(.title3)
                .bold()
        }
        .frame(height: 60)
    }

    var updateButton: some View {
        Button(action: {
            let result = viewModel.updateFriend(
                id: person.id,
                name: detailViewModel.nameLabel,
                canContactWithLINE: isTappedLineButton,
                canContactWithFacebook: isTappedFacebookButton,
                canContactWithTwitter: isTappedTwitterButton,
                canContactWithLinkedIn: isTappedLinkedInButton,
                canContactWithSlack: isTappedSlackButton,
                remark: detailViewModel.remarkLabel,
                remindDate: reminderToggleFlag ? selectedRemindDate : nil
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
        FriendDetailScreen(viewModel: FriendListViewModel(), person: PersonModel(id: "", name: "名前", canContactWithLINE: true, canContactWithFacebook: true, canContactWithTwitter: true, canContactWithLinkedIn: true, canContactWithSlack: true, remark: "メモ", remindDate: nil), cardIndex: 1)
    }
}
