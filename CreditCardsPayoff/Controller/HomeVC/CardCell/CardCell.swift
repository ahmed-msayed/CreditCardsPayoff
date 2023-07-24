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
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        //Add shadow
        self.layer.masksToBounds = false
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
    }
    
    func updateViews(card: Card) {
        titleLabel.text = card.title
        bankLabel.text = card.bank        
        firstFourDigitsLabel.text = card.number == "" ? "XXXX-XXXX-XXXX-XXXX" : "XXXX-XXXX-XXXX-\(card.number.suffix(4))"
        if let limit = Double(card.limit), let available = Double(card.available) {
            let due = limit - available
            dueLabel.text = "\(due.formatted())"
            availableLabel.text = "\(available.formatted())"
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
