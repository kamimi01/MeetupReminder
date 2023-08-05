//
//  FriendDetailScreen.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import SwiftUI

struct FriendDetailScreen: View {
    @ObservedObject private var detailViewModel = FriendDetailViewModel()

    let person: PersonModel

    @Environment(\.presentationMode) var presentation
    @FocusState private var isFocused: Bool

    init(person: PersonModel, cardIndex: Int) {
        self.person = person

        detailViewModel.initialize(person: person, cardIndex: cardIndex)

        //ナビゲーションバーの背景色の設定
        UINavigationBar.appearance().barTintColor = UIColor(detailViewModel.cardColor.carViewBackground)
    }

    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()),
                                                count: 3)

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
                            LazyVGrid(columns: columns) {
                                ForEach(ContactMethod.allCases(color: detailViewModel.cardColor), id: \.self) { method in
                                    contactMethodOption(contactMethod: method)
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("通知設定")
                                    .foregroundColor(.mainText)
                                    .padding(.horizontal, 5)
                                Toggle("", isOn: $detailViewModel.isOnReminder)
                                    .toggleStyle(SwitchToggleStyle(tint: detailViewModel.cardColor.cardViewText))
                                Spacer()
                            }
                            if detailViewModel.isOnReminder {
                                HStack {
                                    DatePicker(
                                        "",
                                        selection: $detailViewModel.selectedRemindDate,
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
            detailViewModel.didTapFriendDeleteButton(id: person.id) {
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
            detailViewModel.didTapUpdateFriendButton(
                id: person.id,
                remindDate: detailViewModel.isOnReminder ? detailViewModel.selectedRemindDate : nil
            ) {
                presentation.wrappedValue.dismiss()
            }
        }) {
            Text("完了")
                .foregroundColor(.mainText)
        }
    }

    func contactMethodOption(contactMethod: ContactMethod) -> some View {
        Button(action: {
            detailViewModel.didTapContactButton(contactMethod: contactMethod)
        }) {
            if detailViewModel.isTappedContactMethodButton(contactMethod: contactMethod) {
                return Image(contactMethod.selectImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 70, maxHeight: 70)
            } else {
                return Image(contactMethod.deselectImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 70, maxHeight: 70)
            }
        }
    }
}

struct FriendDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetailScreen(person: PersonModel(id: "", name: "名前", canContactWithLINE: true, canContactWithFacebook: true, canContactWithTwitter: true, canContactWithLinkedIn: true, canContactWithSlack: true, remark: "メモ", remindDate: nil), cardIndex: 1)
    }
}
