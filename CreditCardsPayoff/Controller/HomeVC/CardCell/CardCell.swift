//
//  CardCell.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 15/07/2023.
//

import UIKit

class CardCell: UITableViewCell {
    
    let cardType: CardType = .other
    
    @IBOutlet weak var cardMainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var firstFourDigitsLabel: UILabel!
    @IBOutlet weak var dueLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeViews()
    }
    
    func initializeViews() {
        cardMainView.layer.cornerRadius = 15
        cardMainView.layer.shadowColor = UIColor.lightGray.cgColor
        cardMainView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cardMainView.layer.shadowRadius = 4
        cardMainView.layer.shadowOpacity = 0.5
        cardMainView.layer.masksToBounds = false
    }
    
    func updateViews(card: Card) {
        titleLabel.text = card.title
        bankLabel.text = card.bank
        availableLabel.text = card.available
        firstFourDigitsLabel.text = card.number == "" ? "XXXX-XXXX-XXXX-XXXX" : "XXXX-XXXX-XXXX-\(card.number.suffix(4))"
        if let limit = Double(card.limit), let available = Double(card.available) {
            dueLabel.text = "\(limit - available)"
        }
        
        switch card.type {
        case "mastercard":
            cardImage.image = UIImage(named: "mastercard-100")
        case "visa":
            cardImage.image = UIImage(named: "visa-100")
        case "other":
            cardImage.image = UIImage(named: "magnetic-card-100")
        case .none:
            return
        case .some(_):
            return
        }
    }
}





//func setDatePicker() {
//    datePicker.datePickerMode = .date
//    datePicker.preferredDatePickerStyle = .wheels
//
//    let toolbar = UIToolbar();
//    toolbar.sizeToFit()
//    let doneButton = UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(doneDatePicker));
//    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//    let cancelButton = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
//
//    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//
//    expirationTextField.inputAccessoryView = toolbar
//    expirationTextField.inputView = datePicker
//}
//
//@objc func doneDatePicker() {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "MM/yy"
//    expirationTextField.text = formatter.string(from: datePicker.date)
//    self.view.endEditing(true)
//}
//
//@objc func cancelDatePicker() {
//    self.view.endEditing(true)
//}
//}
//
//enum Card: String {
//case visa = "visa"
//case mastercard = "mastercard"
//case mada = "mada"
//
//var cardString: String {
//    switch self {
//    case .visa:
//        return "visa"
//    case .mastercard:
//        return "mastercard"
//    case .mada:
//        return "mada"
//    }
//}

