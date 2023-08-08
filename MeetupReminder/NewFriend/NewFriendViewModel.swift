//
//  AddFriendViewModel.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/26.
//

import Foundation
import GoogleMobileAds
import UserMessagingPlatform

class NewFriendViewModel: ObservableObject {
    func addFriend(personList: [PersonModel]) {
        setupAdmobIfNeeded(personList: personList)
    }

    private func setupAdmobIfNeeded(personList: [PersonModel]) {
        if fulfilled(personList: personList) == false {
            print("don't setup admob because of not fulfilled")
            return
        }

        let parameters = UMPRequestParameters()
        parameters.tagForUnderAgeOfConsent = false

        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters) { [weak self] requestConsentError in
            guard let self = self else { return }

            if let requestConsentError = requestConsentError {
                print("Error: \(requestConsentError.localizedDescription)")
                return
            }

            if UMPConsentInformation.sharedInstance.formStatus == .available {
                self.loadForm()
            } else {
                print("formstatus of UMPConsentInformation is not available. status is: \(UMPConsentInformation.sharedInstance.formStatus)")
            }
        }
    }

    private func fulfilled(personList: [PersonModel]) -> Bool {
        let numOfPerson = personList.count
        let threshhold = 2
        return threshhold == numOfPerson
    }

    private func loadForm() {
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

                    if UMPConsentInformation.sharedInstance.consentStatus == .obtained {
                        GADMobileAds.sharedInstance().start()
                    } else {
                        print("consentStatus of UMPConsentInformation is not obtained. status is: \(UMPConsentInformation.sharedInstance.consentStatus)")
                    }
                }
            }
        }
    }

    func onAppear() {
        logEvent()
    }

    private func logEvent() {
        let firebaseAnalytics = FirebaseAnalyticsHelper()
        firebaseAnalytics.sendLogEvent(screen: .newfriend)
    }
}
