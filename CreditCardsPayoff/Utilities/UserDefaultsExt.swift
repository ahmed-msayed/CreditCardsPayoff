//
//  UserDefaultsExt.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 26/06/2023.
//

import Foundation

extension UserDefaults{

    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

    func setUserID(value: String) {
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
    }

    func getUserID() -> String {
        return string(forKey: UserDefaultsKeys.userID.rawValue) ?? ""
    }
    
    func setFirstName(value: String) {
        set(value, forKey: UserDefaultsKeys.firstName.rawValue)
    }
    
    func getFirstName() -> String {
        return string(forKey: UserDefaultsKeys.firstName.rawValue) ?? ""
    }
    
    func setLastName(value: String) {
        set(value, forKey: UserDefaultsKeys.lastName.rawValue)
    }
    
    func getLastName() -> String {
        return string(forKey: UserDefaultsKeys.lastName.rawValue) ?? ""
    }
    
    enum UserDefaultsKeys : String, CaseIterable {
        case isLoggedIn
        case userID
        case firstName
        case lastName
    }
    
    func resetUserDefaults() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.set("", forKey: "userID")
        UserDefaults.standard.set("", forKey: "firstName")
        UserDefaults.standard.set("", forKey: "lastName")
    }
}


