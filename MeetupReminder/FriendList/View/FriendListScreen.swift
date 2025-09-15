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
                VStack {
                    if viewModel.personList.isEmpty {
                        friendEmptyView()
                    } else {
                        friendListView()
                    }
//                    AdmobBannerView()
//                        .frame(width: 320, height: 50)
                }
                addButton
                    .position(x: UIScreen.main.bounds.width - 70, y: UIScreen.main.bounds.height - 280)
            }
            .navigationTitle("Friend")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    appInfoButton
                }
            }
        }
        .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearchPresented, prompt: "Search")
        .onSubmit(of: .search) {
            viewModel.search()
        }
        .onChange(of: viewModel.isSearchPresented) { _, newValue in
            if !newValue {
                print("Searching cancelled")
                viewModel.resetSearch()
            }
        }
        .accentColor(.mainText)
        .onAppear {
            viewModel.onAppear()
        }
        .onChange(of: scenePhase) { _, phase in
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
    func friendEmptyView() -> some View {
        VStack {
            Spacer()
            LottieView(animationType: .friendships)
                .frame(width: 250, height: 180)
            Spacer()
        }
    }

    func friendListView() -> some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(Array(viewModel.personList.enumerated()), id: \.offset) { personIndex, person in
                    NavigationLink(destination: FriendDetailScreen(viewModel: FriendDetailViewModel(), person: person, cardIndex: personIndex)) {
                        FriendCardView(person: person, cardIndex: personIndex)
                             .padding(.horizontal, 20)
                    }
                }
                Color.mainBackground
                    .frame(height: 170)
            }
        }
    }

    var appInfoButton: some View {
        Button(action: {
            viewModel.didTapInfoButton()
        }) {
            Image(systemName: "info.circle")
                .foregroundColor(.mainText)
        }
        .fullScreenCover(isPresented: $viewModel.isShowingAppInfoScreen) {
            SettingScreen(viewModel: SettingViewModel())
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
            NewFriendScreen(viewModel: NewFriendViewModel(), personList: viewModel.personList)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListScreen(viewModel: FriendListViewModel())
    }
}
