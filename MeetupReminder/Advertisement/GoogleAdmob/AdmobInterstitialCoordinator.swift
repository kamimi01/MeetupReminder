//
//  AdmobInterstitialCoordinator.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/11.
//

import Foundation
import GoogleMobileAds

class AdmobInterstitialCoordinator: NSObject {

    override init() {
        super.init()
        loadAd()
    }

    private var ad: GADInterstitialAd?

    private func loadAd() {
        Task {
            do {
                let ad = try await GADInterstitialAd.load(
                    withAdUnitID: Configuration.shared.admobInterstitialUnitID,
                    request: GADRequest()
                )
                self.ad = ad
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func presentAd(from viewController: UIViewController) {
        guard let fullScreenAd = ad else {
            return print("Ad wasn't ready")
        }
        fullScreenAd.present(fromRootViewController: viewController)
    }
}

// MARK: - GADFullScreenContentDelegate methods

extension AdmobInterstitialCoordinator: GADFullScreenContentDelegate {
    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }

    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("\(#function) called")
    }

    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }


    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
}
