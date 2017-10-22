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
    var users: [String] = []
    
    // MARK: - Accessor methods
    
    func append(user: String) {
        
    }

    func delete(user: String) {
        
    }

    // MARK: - User default

    func store() {
        UserDefaults.standard.set(users, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func retrieve() {
        if let usersData = UserDefaults.standard.object(forKey: key) as? NSData,
            let decodedUsers = NSKeyedUnarchiver.unarchiveObject(with: usersData as Data) as? [String] {
            users = decodedUsers
        }
    }
}
