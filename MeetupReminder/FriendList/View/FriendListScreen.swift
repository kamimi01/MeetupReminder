//
//  ContentView.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/24.
//

import SwiftUI
import UserMessagingPlatform
import GoogleMobileAds

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
                    AdmobBannerView()
                        .frame(width: 320, height: 50)
                }
                addButton
                    .position(x: UIScreen.main.bounds.width - 70, y: UIScreen.main.bounds.height - 280)
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
            setupAdmob()
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
            LazyVStack(spacing: 15) {
                ForEach(Array(viewModel.personList.enumerated()), id: \.offset) { personIndex, person in
                    NavigationLink(destination: FriendDetailScreen(viewModel: FriendDetailViewModel(), person: person, cardIndex: personIndex)) {
                        FriendCardView(person: person, cardIndex: personIndex)
                             .padding(.horizontal, 16)
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
            NewFriendScreen(personList: viewModel.personList)
        }
    }

    func setupAdmob() {
        let parameters = UMPRequestParameters()
        parameters.tagForUnderAgeOfConsent = false

        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters) { requestConsentError in

            if let requestConsentError = requestConsentError {
                print("Error: \(requestConsentError.localizedDescription)")
                return
            }

            if UMPConsentInformation.sharedInstance.formStatus == .available {
                loadForm()
            } else {
                print("formstatus of UMPConsentInformation is not available. status is: \(UMPConsentInformation.sharedInstance.formStatus)")
            }
        }
    }

    func loadForm() {
        UMPConsentForm.load { form, loadError in

            if let loadError = loadError {
                print("Error: \(loadError.localizedDescription)")
                return
            }

            if UMPConsentInformation.sharedInstance.consentStatus == .required {

                guard let rootViewController = UIApplication.shared.rootViewController else {
                    print("Cannot get rootviewcontroller")
                    return
                }

                form?.present(from: rootViewController) { dismissError in

                    if let dismissError = dismissError {
                        print("Error: \(dismissError.localizedDescription)")
                        return
                    }

                    print("status is: \(UMPConsentInformation.sharedInstance.consentStatus)")
                    if UMPConsentInformation.sharedInstance.consentStatus == .obtained {
                        GADMobileAds.sharedInstance().start()
                    } else {
                        print("consentStatus of UMPConsentInformation is not obtained. status is: \(UMPConsentInformation.sharedInstance.consentStatus)")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListScreen(viewModel: FriendListViewModel())
    }
}
