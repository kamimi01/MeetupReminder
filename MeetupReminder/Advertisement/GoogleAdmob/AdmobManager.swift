//
//  AdmobManager.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/10.
//

//import Foundation
//import GoogleMobileAds
//import UserMessagingPlatform
//
//struct AdmobManager {
//    static func configure() {
//        Task {
//            await setupAdmobIfNeeded()
//        }
//    }
//
//    private static func setupAdmobIfNeeded() async {
//        do {
//            try await presentFormIfPossible()
//            await setupAdmob()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    private static func presentFormIfPossible() async throws {
//        let parameters = UMPRequestParameters()
//        parameters.tagForUnderAgeOfConsent = false
//
//        try await UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters)
//
//        let formStatus = UMPConsentInformation.sharedInstance.formStatus
//        if formStatus != .available {
//            throw UMPError.formStatusIsNotAvailable(formStatus)
//        }
//
//        try await loadAndPresentIfPossible()
//
//        if UMPConsentInformation.sharedInstance.canRequestAds == false {
//            throw UMPError.cannotRequestAds
//        }
//    }
//
//    @MainActor
//    private static func loadAndPresentIfPossible() async throws {
//        guard let rootViewController = UIApplication.shared.rootViewController else {
//            throw UMPError.cannotGetRootViewController
//        }
//        try await UMPConsentForm.loadAndPresentIfRequired(from: rootViewController)
//    }
//
//    private static func setupAdmob() async {
//        print(#function)
//        await GADMobileAds.sharedInstance().start()
//    }
//
//    private enum UMPError: Error {
//        /// formStatus が available ではない
//        case formStatusIsNotAvailable(_ formStatus: UMPFormStatus)
//        /// ads をリクエストできない
//        case cannotRequestAds
//        /// rootViewController を取得できない
//        case cannotGetRootViewController
//    }
//}
