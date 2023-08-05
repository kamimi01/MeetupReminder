//
//  FriendDetailScreen.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import SwiftUI

struct FriendDetailScreen<ViewModel: FriendDetailViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    @Environment(\.presentationMode) var presentation
    @FocusState private var isFocused: Bool

    init(viewModel: ViewModel, person: PersonModel, cardIndex: Int) {
        self.viewModel = viewModel
        viewModel.initialize(person: person, cardIndex: cardIndex)

        //ナビゲーションバーの背景色の設定
        UINavigationBar.appearance().barTintColor = UIColor(viewModel.cardColor.carViewBackground)
    }

    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()),
                                                count: 3)

        ZStack {
            viewModel.cardColor.carViewBackground
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 20) {
                    profileImage
                    VStack(alignment: .leading, spacing: 40) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("メモ")
                                .foregroundColor(.mainText)
                                .padding(.horizontal, 5)
                            TextField("高校の友達。今度ランチに行く。", text: $viewModel.remarkLabel, axis: .vertical)
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
                                ForEach(ContactMethod.allCases(color: viewModel.cardColor), id: \.self) { method in
                                    contactMethodOption(contactMethod: method)
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("通知設定")
                                    .foregroundColor(.mainText)
                                    .padding(.horizontal, 5)
                                Toggle("", isOn: $viewModel.isOnReminder)
                                    .toggleStyle(SwitchToggleStyle(tint: viewModel.cardColor.cardViewText))
                                Spacer()
                            }
                            if viewModel.isOnReminder {
                                HStack {
                                    DatePicker(
                                        "",
                                        selection: $viewModel.selectedRemindDate,
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
            Image(viewModel.cardColor.profileImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.mainBackground)
                .clipShape(Circle())
                .frame(maxWidth: 130, maxHeight: 130)
            TextField("なまえ", text: $viewModel.nameLabel)
                .frame(width: 200)
                .font(.title2)
                .foregroundColor(.mainText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
    }

    var deleteButton: some View {
        Button(action: {
            viewModel.didTapFriendDeleteButton() {
                self.presentation.wrappedValue.dismiss()
            }
        }) {
            Text("ともだちから削除")
                .foregroundColor(viewModel.cardColor.cardViewText)
                .font(.title3)
                .bold()
        }
        .frame(height: 60)
    }

    var updateButton: some View {
        Button(action: {
            viewModel.didTapUpdateFriendButton {
                presentation.wrappedValue.dismiss()
            }
        }) {
            Text("完了")
                .foregroundColor(.mainText)
        }
    }

    func contactMethodOption(contactMethod: ContactMethod) -> some View {
        Button(action: {
            viewModel.didTapContactButton(contactMethod: contactMethod)
        }) {
            Image(viewModel.isTappedContactMethodButton(contactMethod: contactMethod) ? contactMethod.selectImage : contactMethod.deselectImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 70, maxHeight: 70)
        }
    }
}

struct FriendDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let person = PersonModel()
        FriendDetailScreen(viewModel: FriendDetailViewModel(), person: person, cardIndex: 1)
    }
}
