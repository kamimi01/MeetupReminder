//
//  MeetupReminderApp.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        // Firebase の初期化設定
        FirebaseApp.configure()

        // Admob の初期化設定
        AdmobManager.configure()

        return true
    }
}

@main
struct MeetupReminderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            FriendListScreen(viewModel: FriendListViewModel())
        }
    }
}
