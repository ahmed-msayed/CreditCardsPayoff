//
//  CurrencyVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 11/07/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CurrencyVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerDataSource = CurrencyList().pickerCurrencyList
    let db = Firestore.firestore()
    var isDismissed: (() -> Void)?
    var selectedCurrencyCode = CurrencyVM.getLocalUserCurrency()?.currencyCode
    var selectedCurrencyCountry = CurrencyVM.getLocalUserCurrency()?.country
    var pickerCurrentCurrency = 0
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        initializeCurrentPickerItem()
    }
    
    func initializeCurrentPickerItem() {
        guard let savedCurrency = CurrencyVM.getLocalUserCurrency() else {return}
        if let index = pickerDataSource.firstIndex(where: {$0.country == savedCurrency.country}) {
            pickerCurrentCurrency = index
        }
        pickerView.selectRow(pickerCurrentCurrency, inComponent: 0, animated: true)
    }
    
    @IBAction func selectCurrencyButtonClick(_ sender: Any) {
        let currency = Currency(country: self.selectedCurrencyCountry, currencyCode: self.selectedCurrencyCode)
        let currencyVM = CurrencyVM(currency: currency)
        currencyVM.saveCurrencyLocally()
        UserDefaults.standard.synchronize()
        self.dismissModalVC()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = view as? UILabel ?? UILabel()
        let hue = CGFloat(row)/CGFloat(pickerDataSource.count)
        label.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 0.5)
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.text = pickerDataSource[row].country + " " + pickerDataSource[row].currencyCode
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCurrencyCode = pickerDataSource[row].currencyCode
        self.selectedCurrencyCountry = pickerDataSource[row].country
    }
    
    func dismissModalVC() {
        self.isDismissed?()
        dismiss(animated: true)
        notificationCenterReloadHomeTable()
    }
    
    func notificationCenterReloadHomeTable() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTableView"), object: nil)
    }
}
