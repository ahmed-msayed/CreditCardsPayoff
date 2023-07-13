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
    
    func saveCurrencyLocally() {
        UserDefaults.standard.saveObject(rawData: self.currency, forKey: "userCurrency")
    }
    
    static func getLocalUserCurrency() -> CurrencyVM? {
        if let currency: Currency = UserDefaults.standard.getObject(key: "userCurrency") {
            return CurrencyVM(currency: currency)
        }
        return nil
    }
}
