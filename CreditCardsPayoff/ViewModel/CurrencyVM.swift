//
//  CurrencyVM.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 12/07/2023.
//

import Foundation

struct CurrencyVM {
    var currency: Currency
    
    var country: String {
        return currency.country ?? ""
    }
    
    var currencyCode: String {
        return currency.currencyCode ?? ""
    }
    
    func saveUserCurrency() {
        UserDefaults.standard.set(currency.country, forKey: "userCurrencyCountry")
        UserDefaults.standard.set(currency.currencyCode, forKey: "userCurrencyCode")
    }
    
    static func getUserCurrencyCode() -> String {
        if let currencyCode = UserDefaults.standard.string(forKey: "userCurrencyCode") {
            return currencyCode
        }
        return ""
    }
    
    static func getUserCurrencyCountry() -> String {
        if let currencyCountry = UserDefaults.standard.string(forKey: "userCurrencyCountry") {
            return currencyCountry
        }
        return ""
    }
}
