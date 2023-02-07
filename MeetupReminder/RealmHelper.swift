//
//  RealmHelper.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/26.
//

import Foundation
import RealmSwift

class RealmHelper {
    static let shared = RealmHelper()
    private let realm: Realm

    init() {
        let key = RealmHelper.getKey()
        let config = Realm.Configuration(encryptionKey: key, schemaVersion: 2)
        realm = try! Realm(configuration: config)

        print("key:", key.map { String(format: "%.2hhx", $0) }.joined())
    }

    // あれば既存の暗号化キーを取得する。なければ新しく作成する
    private static func getKey() -> Data {

        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = "io.Realm.EncryptionExampleKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        // 既存のキーがあるか確認する
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]

        // Swiftの最適化のバグを避けるため、withUnsafeMutablePointer() を使って、キーチェーンからitemを取り出す
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }

        // 事前に作成されたキーがない場合、新しく生成する
        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })

        // キーチェーンにキーを保存する
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]

        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")

        return key
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
                }
                return true
            } catch {
                print("削除に失敗しました")
                return false
            }
        } else {
            fatalError("削除対象が見つかりませんでした")
        }
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
        remark: String? = nil,
        remindDate: Date? = nil
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
                    willUpdateFriend.remindDate = remindDate
                }
                return true
            } catch {
                print("更新に失敗しました")
                return false
            }
        } else {
            fatalError("更新対象データが見つかりませんでした")
        }
    }
}
