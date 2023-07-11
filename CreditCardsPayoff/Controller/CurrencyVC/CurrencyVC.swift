//
//  CurrencyVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 11/07/2023.
//

import UIKit

class CurrencyVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerDataSource = ["White", "Red", "Green", "Blue"]

    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
}
