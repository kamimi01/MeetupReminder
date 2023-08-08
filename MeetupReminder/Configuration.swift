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

    /// Google Admob の広告 ID
    let admobUnitID: String

    enum AppConfig: String {
        case admobUnitID = "AdmobUnitID"
    }

    private init() {
        admobUnitID = config[AppConfig.admobUnitID.rawValue] as! String
    }
}
