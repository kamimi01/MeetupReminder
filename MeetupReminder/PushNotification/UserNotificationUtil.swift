//
//  UserNotificationUtil.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/02/05.
//

import Foundation
import UserNotifications

class UserNotificationUtil: NSObject {
    static var shared = UserNotificationUtil()
    private var center = UNUserNotificationCenter.current()

    func initialize() {
        center.delegate = UserNotificationUtil.shared
    }

    /// 通知許可をしたかどうかを判定する
    func showPushPermission(completion: @escaping (Result<Bool, Error>) -> Void) {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            completion(.success(isGranted))
        }
    }

    func setTimeRequest(of taskId: String, date: Date) {
        // 5秒後に通知を送る
//        let trigger2 = UNTimeIntervalNotificationTrigger(
//            timeInterval: TimeInterval(5),
//            repeats: false
//        )
        // 指定の時間に送る
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: date.components,
            repeats: false
        )
        // 通知される内容
        let content = UNMutableNotificationContent()
        content.body = "テストメッセージ"
        content.badge = 1
        content.sound = .default
        // リクエストを作成
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        // 通知センターにセットする
        center.add(request) { error in
            if let error = error {
                print("local notification is failed: \(error.localizedDescription)")
            }
        }
    }
}

extension UserNotificationUtil: UNUserNotificationCenterDelegate {
    /// フォアグラウンドで通知を受信した時に実行される処理
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
            print("フォアグラウンドで通知を受信")
            completionHandler([.banner, .list, .sound, .badge])
    }

    /// 通知をタップした時に実行される処理
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("通知をタップした時に実行される処理")
        completionHandler()
    }
}
