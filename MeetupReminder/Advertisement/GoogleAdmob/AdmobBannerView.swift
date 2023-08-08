//
//  AdmobBannerView.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/08.
//

import Foundation
import SwiftUI
import GoogleMobileAds

struct AdmobBannerView: UIViewRepresentable {

    func makeUIView(context: Context) -> GADBannerView {
        let view = GADBannerView(adSize: GADAdSizeBanner)
        view.adUnitID = Configuration.shared.admobUnitID
        view.rootViewController = UIApplication.shared.rootViewController
        view.load(GADRequest())
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct AdmobBannerView_Previews: PreviewProvider {
    static var previews: some View {
        AdmobBannerView()
    }
}
