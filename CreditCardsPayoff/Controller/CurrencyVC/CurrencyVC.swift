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
    var selectedCurrency = ""
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func selectCurrencyButtonClick(_ sender: Any) {
        saveUserCurrencyToDB()
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
        label.text = pickerDataSource[row].country + " " + pickerDataSource[row].currency_code
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCurrency = pickerDataSource[row].currency_code
    }
    
    func saveUserCurrencyToDB() {
//        let currency: Currency?
//        currency.userCurrency = self.selectedCurrency
//        guard let currency = currency else { return }
//        let currencyVM = CurrencyVM(currency: currency)
//        currencyVM.saveUserCurrency()
        UserDefaults.standard.set(self.selectedCurrency, forKey: "userCurrency")
        UserDefaults.standard.synchronize()
        self.dismissModalVC()
    }
    
    func dismissModalVC() {
        self.isDismissed?()
        dismiss(animated: true)
    }
}
