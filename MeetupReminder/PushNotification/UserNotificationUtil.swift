//
//  UserNotificationUtil.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/02/05.
//

import Foundation
import UserNotifications
import UIKit

class UserNotificationUtil: NSObject {
    static var shared = UserNotificationUtil()
    private var center = UNUserNotificationCenter.current()

    func initialize() {
        center.delegate = UserNotificationUtil.shared
    }

    func resetNotification() {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func hasPendingNotification(id: String, completion: @escaping (Bool) -> Void) {
        center.getPendingNotificationRequests { requests in
            for request in requests {
                if request.identifier == id {
                    completion(true)
                }
            }
            completion(false)
        }
    }

    /// 通知許可をしたかどうかを判定する（同じIDで通知を設定すると以前設定された通知が上書きされるので、通知のupdateメソッドは実装していない）
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

    func deleteRequest(id: String) {
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }

    func setTimeRequest(of person: PersonModel, date: Date) {
        // 指定の時間に送る
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: date.components,
            repeats: false
        )
        // 通知される内容
        let content = UNMutableNotificationContent()
        content.body = "\(person.name) さんに連絡をとってみましょう"
        content.badge = 1
        content.sound = .default
        // リクエストを作成
        let request = UNNotificationRequest(
            identifier: person.id,
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
        // TODO: ディープリンクを実装したい
        completionHandler([.banner, .list, .sound, .badge])
    }

    /// 通知をタップした時に実行される処理
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("通知をタップした時に実行される処理")
        // TODO: ディープリンクを実装したい
        completionHandler()
    }
}
