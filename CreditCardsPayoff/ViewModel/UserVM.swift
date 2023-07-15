//
//  User.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 26/06/2023.
//

import Foundation

struct UserVM {
    var user: User
    
    var userId: String {
        return user.userId ?? ""
    }
    var firstName: String {
        return user.firstName ?? ""
    }
    var lastName: String {
        return user.lastName ?? ""
    }
    var email: String {
        return user.email ?? ""
    }

    static var isLoggedIn: Bool {
        return UserVM.getLocalUser() != nil
    }
    
    func saveUserLocally() {
        UserDefaults.standard.saveObject(rawData: self.user, forKey: "userAccount")
    }
    
    static func getLocalUser() -> UserVM? {
        if let user: User = UserDefaults.standard.getObject(key: "userAccount") {
            return UserVM(user: user)
        }
        return nil
    }
    
    static func removeLocalUser() {
        UserDefaults.standard.removeObject(forKey: "userAccount")
//        UserDefaults.standard.removeObject(forKey: "\((UserVM.getLocalUser()?.email) ?? "")userCurrency")
        UserDefaults.standard.synchronize()
    }
}
