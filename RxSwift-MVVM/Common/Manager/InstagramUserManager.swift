//
//  InstagramUserManager.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/23/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation

class InstagramUserManager {
    
    static let shared = InstagramUserManager()

    let key: String = "InstagramSavedUsersKey"
    private var users: [String] = []

    private init() {
        retrieve()
    }
    
    // MARK: - Accessor methods

    func getAllUser() -> [String] {
        return users
    }
    
    func append(user: String) {
        users.append(user)
        store()
    }

    func delete(user: String) {
        users = users.filter({ $0 != user })
        store()
    }

    // MARK: - User default

    func store() {
        UserDefaults.standard.set(users, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func retrieve() {
        guard let usersData = UserDefaults.standard.object(forKey: key) as? NSData else { return }
        guard let decodedUsers = NSKeyedUnarchiver.unarchiveObject(with: usersData as Data) as? [String] else { return }
        users = decodedUsers
    }
}
