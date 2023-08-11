//
//  AddFriendScreen.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import SwiftUI

struct NewFriendScreen: View {
    @ObservedObject private var viewModel = NewFriendViewModel()

    /// アプリレビュー画面を表示するための条件として使用している
    private let personList: [PersonModel]

    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool

    init(personList: [PersonModel]){
        self.personList = personList
    }

    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

        NavigationView {
            ZStack {
                viewModel.cardColor.cardViewBackground
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(spacing: 20) {
                        profileImage
                        VStack(alignment: .leading, spacing: 40) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("メモ")
                                    .foregroundColor(.mainText)
                                    .padding(.horizontal, 5)
                                TextField("会社の同僚。悩み相談先。", text: $viewModel.remarkLabel, axis: .vertical)
                                    .padding()
                                    .frame(height: 110.0, alignment: .top)
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
                        }
                        .padding(16)
                        Spacer()
                    }
                }
                VStack {
                    Spacer()
                    AdmobBannerView()
                        .frame(width: 320, height: 50)
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
            .toolbarBackground(Color.cardViewRed, for: .navigationBar)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: - Private Properties and Methods

private extension NewFriendScreen {
    var profileImage: some View {
        VStack(spacing: 10) {
            Image(viewModel.cardColor.profileImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.mainBackground)
                .clipShape(Circle())
                .frame(maxWidth: 130, maxHeight: 130)
            TextField("", text: $viewModel.nameLabel, prompt: Text("なまえ"))
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
            viewModel.didTapAddButton {
                dismiss()
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    // レビューダイアログの表示
                    let appReview = AppReview(personList: personList)
                    appReview.requestReview(in: windowScene)
                }
            }
        }) {
            Text("追加")
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

struct AddFriendScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewFriendScreen(personList: [PersonModel(id: "", name: "加藤花子", canContactWithLINE: false, canContactWithFacebook: false, canContactWithTwitter: false, canContactWithLinkedIn: false, canContactWithSlack: false, remark: "", remindDate: nil)])
    }
}
