//
//  ContentView.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/24.
//

import SwiftUI

struct FriendListScreen<ViewModel: FriendListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
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
                                NavigationLink(destination: FriendDetailScreen(person: person, cardIndex: personIndex)) {
                                    FriendCardView(person: person, cardIndex: personIndex)
                                         .padding(.horizontal, 16)
                                }
                            }
                            Color.mainBackground
                                .frame(height: 170)
                        }
                    }
                }
                addButton
                    .position(x: UIScreen.main.bounds.width - 70, y: UIScreen.main.bounds.height - 240)
            }
            .navigationTitle("ともだち")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    appInfoButton
                }
            }
        }
        .accentColor(.mainText)
        .onAppear {
            viewModel.onAppear()
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
                viewModel.didActivate()
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

// MARK: - Private Properties and Methods

private extension FriendListScreen {
    var appInfoButton: some View {
        Button(action: {
            viewModel.didTapInfoButton()
        }) {
            Image(systemName: "info.circle")
                .foregroundColor(.mainText)
        }
        .fullScreenCover(isPresented: $viewModel.isShowingAppInfoScreen) {
            SettingScreen()
        }
    }

    var addButton: some View {
        Button(action: {
            viewModel.didTapAddButton()
        }) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
        }
        .frame(width: 60, height: 60)
        .background(Color.cardViewTextRed)
        .foregroundColor(.white)
        .clipShape(Circle())
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        .fullScreenCover(isPresented: $viewModel.isShowingAddFriendScreen) {
            NewFriendScreen(personList: viewModel.personList)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListScreen(viewModel: FriendListViewModel())
    }
}
