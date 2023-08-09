//
//  AddFriendViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/26.
//

import Foundation
import GoogleMobileAds
import UserMessagingPlatform

enum UMPError: Error {
    /// formStatus が available ではない
    case formStatusIsNotAvailable(_ formStatus: UMPFormStatus)
    /// ads をリクエストできない
    case cannotRequestAds
    /// rootViewController を取得できない
    case cannotGetRootViewController
}

class NewFriendViewModel: ObservableObject {
    func addFriend(personList: [PersonModel]) {
        Task {
            await setupAdmobIfNeeded(personList: personList)
        }
    }

    private func setupAdmobIfNeeded(personList: [PersonModel]) async {
        if fulfilled(personList: personList) == false {
            print("don't setup admob because of not fulfilled")
            return
        }

        do {
            try await presentFormIfPossible()
            await setupAdmob()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func fulfilled(personList: [PersonModel]) -> Bool {
        let numOfPerson = personList.count
        let threshhold = 2
        return threshhold == numOfPerson
    }

    private func presentFormIfPossible() async throws {
        let parameters = UMPRequestParameters()
        parameters.tagForUnderAgeOfConsent = false

        try await UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters)

        let formStatus = UMPConsentInformation.sharedInstance.formStatus
        if formStatus != .available {
            throw UMPError.formStatusIsNotAvailable(formStatus)
        }

        try await loadAndPresentIfPossible()

        if UMPConsentInformation.sharedInstance.canRequestAds == false {
            throw UMPError.cannotRequestAds
        }
    }

    @MainActor
    private func loadAndPresentIfPossible() async throws {
        guard let rootViewController = UIApplication.shared.rootViewController else {
            throw UMPError.cannotGetRootViewController
        }
        try await UMPConsentForm.loadAndPresentIfRequired(from: rootViewController)
    }

    private func setupAdmob() async {
        print(#function)
        await GADMobileAds.sharedInstance().start()
    }

    func onAppear() {
        logEvent()
    }

    private func logEvent() {
        let firebaseAnalytics = FirebaseAnalyticsHelper()
        firebaseAnalytics.sendLogEvent(screen: .newfriend)
    }
}
