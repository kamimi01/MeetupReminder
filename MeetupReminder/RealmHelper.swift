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
            print("追加に失敗しました")
        }
        return false
    }

    func deleteFriend(id: String) -> Bool {
        let willDeleteFriends = realm.objects(Person.self).where {
            $0.id == id
        }
        if let willDeleteFriend = willDeleteFriends.first {
            do {
                try realm.write {
                    realm.delete(willDeleteFriend)
                    return true
                }
            } catch {
                print("削除に失敗しました")
            }
        } else {
            fatalError("削除対象が見つかりませんでした")
        }
        return false
    }

    // FIXME: 変更を監視するため、ここだけRealmのオブジェクトを返している
    func loadFriends() -> Results<Person> {
        let result = realm.objects(Person.self)
        print("Realmのファイルの場所：", Realm.Configuration.defaultConfiguration.fileURL)
        return result
    }

    func updateFriend(
        id: String,
        name: String? = nil,
        canContactWithLINE: Bool? = nil,
        canContactWithFacebook: Bool? = nil,
        canContactWithTwitter: Bool? = nil,
        canContactWithLinkedIn: Bool? = nil,
        canContactWithSlack: Bool? = nil,
        remark: String? = nil
    ) -> Bool {
        let willUpdateFriends = realm.objects(Person.self).where {
            $0.id == id
        }
        if let willUpdateFriend = willUpdateFriends.first {
            do {
                try realm.write {
                    if let newName = name {
                        willUpdateFriend.name = newName
                    }
                    if let newCanContactWithLINE = canContactWithLINE {
                        willUpdateFriend.canContactWithLINE = newCanContactWithLINE
                    }
                    if let newCanContactWithFacebook = canContactWithFacebook {
                        willUpdateFriend.canContactWithFacebook = newCanContactWithFacebook
                    }
                    if let newCanContactWithTwitter = canContactWithTwitter {
                        willUpdateFriend.canContactWithTwitter = newCanContactWithTwitter
                    }
                    if let newCanContactWithLinkedIn = canContactWithLinkedIn {
                        willUpdateFriend.canContactWithLinkedIn = newCanContactWithLinkedIn
                    }
                    if let newCanContactWithSlack = canContactWithSlack {
                        willUpdateFriend.canContactWithSlack = newCanContactWithSlack
                    }
                    if let newRemark = remark {
                        willUpdateFriend.remark = newRemark
                    }
                }
                return true
            } catch {
                print("更新に失敗しました")
                return false
            }
        } else {
            print("更新対象データが見つかりませんでした")
            return false
        }
    }
}
