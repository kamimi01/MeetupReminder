//
//  AppReview.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/02/10.
//

import Foundation
import StoreKit

class AppReview {
    let personList: [PersonModel]

    init(personList: [PersonModel]) {
        self.personList = personList
    }

    func requestReview(in window: UIWindowScene) {
        if fullfilled {
            Task { @MainActor in
                // ユーザーがアプリで操作をしてしまわないよう2秒待機する
                try? await Task.sleep(nanoseconds: UInt64(2e9))
                SKStoreReviewController.requestReview(in: window)
            }
        }
    }

    private var fullfilled: Bool {
        let numOfPerson = personList.count
        let threshholdList = [4, 9, 19]
        if threshholdList.contains(numOfPerson) {
            return true
        }
        return false
    }
}
