//
//  Helper.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 09/08/2023.
//

import Foundation

class Helper {
    static var shared = Helper()
    
    var isDarkMode: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: "isDarkMode")
        } set {
            UserDefaults.standard.set(newValue, forKey: "isDarkMode")
        }
    }
}
