//
//  Configuration.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/08.
//

import Foundation

struct Configuration {
    static let shared = Configuration()

    private let config: [AnyHashable: Any] = {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile: path) as! [AnyHashable: Any]
        return plist["AppConfig"] as! [AnyHashable: Any]
     }()

    /// Google Admob のバナー広告 ID
    let admobBannerUnitID: String
    /// Google Admob のインタースティシャル広告 ID
    let admobInterstitialUnitID: String

    enum AppConfig: String {
        case admobBannerUnitID = "AdmobBannerUnitID"
        case admobInterstitialUnitID = "AdmobInterstitialUnitID"
    }

    private init() {
        admobBannerUnitID = config[AppConfig.admobBannerUnitID.rawValue] as! String
        admobInterstitialUnitID = config[AppConfig.admobInterstitialUnitID.rawValue] as! String
    }
}
