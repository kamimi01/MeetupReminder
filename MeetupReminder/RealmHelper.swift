//
//  RealmHelper.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/26.
//

import Foundation
import RealmSwift

class RealmHelper {
    private let realm: Realm

    init() {
        realm = try! Realm()
    }

    func addFriend(person: Person) -> Bool {
        do {
            try realm.write {
                realm.add(person)
            }
            return true
        } catch {
            print("保存に失敗しました")
        }
        return false
    }

    func loadFriends() -> [Person] {
        let result = realm.objects(Person.self)
        print("Realmのファイルの場所：", Realm.Configuration.defaultConfiguration.fileURL)
        return Array(result)
    }
}
