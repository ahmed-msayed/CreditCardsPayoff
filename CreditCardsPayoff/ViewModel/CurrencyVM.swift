//
//  CurrencyVM.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 12/07/2023.
//

import Foundation

struct CurrencyVM {
    var currency: Currency
    
    var userCurrency: String {
        return currency.userCurrency ?? ""
    }
    
    func saveUserCurrency() {
        UserDefaults.standard.set(currency.userCurrency, forKey: "userCurrency")
    }
}
